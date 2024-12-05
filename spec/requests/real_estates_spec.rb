# frozen_string_literal: true

require "rails_helper"

RSpec.describe("RealEstates", type: :request) do
  let(:user) { FactoryBot.create(:user) }

  let(:role) { "viewer" }
  let(:membership) { FactoryBot.build(:membership, user: user, role: role) }
  let(:real_estate) { FactoryBot.create(:real_estate, membership: membership) }

  let(:valid_attributes) do
    {
      name: "demo",
      street: "Demo Str. 4",
      zip_code: 81667,
      city: "München",
      units: 3,
      space: 80,
      built_at: "11/1987",
      heating_type: "oil",
      solar_plant_present: false,
    }
  end

  let(:invalid_attributes) do
    { name: "" }
  end

  before do
    sign_in(user)
  end

  describe "GET /" do
    it "renders a successful response" do
      get real_estates_url
      expect(response).to(be_successful)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get real_estate_url(real_estate)
      expect(response).to(be_successful)
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_real_estate_url
      expect(response).to(be_successful)
    end
  end

  describe "GET /edit" do
    context "owner" do
      let(:role) { "owner" }

      it "renders a successful response" do
        get edit_real_estate_url(real_estate)
        expect(response).to(be_successful)
      end
    end

    it "returns forbidden" do
      get edit_real_estate_url(real_estate)
      expect(response).to(have_http_status(:forbidden))
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new RealEstate" do
        expect do
          post(real_estates_url, params: { real_estate: valid_attributes })
        end.to(change(
          RealEstate,
          :count,
        ).by(1).and(change(Membership, :count).by(1).and(change(Collection, :count).by(1))))
      end

      it "redirects to the created real_estate" do
        post real_estates_url, params: { real_estate: valid_attributes }
        expect(response).to(redirect_to(real_estate_url(RealEstate.last)))
      end

      it "renders as turbo_stream response" do
        post real_estates_url, params: { real_estate: valid_attributes }, as: :turbo_stream
        expect(response).to(have_http_status(:ok))
        expect(response.body).to(match(/action="replace" target="main_content"/))
      end

      it "creates a owner membership" do
        post real_estates_url, params: { real_estate: valid_attributes }
        expect(Membership.last.owner?).to(be_truthy)
      end
    end

    context "with invalid parameters" do
      it "does not create a new RealEstate" do
        expect do
          post(real_estates_url, params: { real_estate: invalid_attributes })
        end.to(change(
          RealEstate,
          :count,
        ).by(0).and(change(Membership, :count).by(0).and(change(Collection, :count).by(0))))
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post real_estates_url, params: { real_estate: invalid_attributes }
        expect(response).to(have_http_status(:unprocessable_entity))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { name: "Updated Name" }
      end

      context "owner" do
        let(:role) { "owner" }

        it "updates the requested real_estate" do
          patch real_estate_url(real_estate), params: { real_estate: new_attributes }
          expect do
            real_estate.reload
          end.to(change(real_estate, :name).from("Muster Objekt").to("Updated Name"))
        end

        it "redirects to the real_estate" do
          patch real_estate_url(real_estate), params: { real_estate: new_attributes }
          expect(response).to(redirect_to(real_estate_url(real_estate)))
        end

        it "redirects to the real_estate at trubo_stream" do
          patch real_estate_url(real_estate), params: { real_estate: new_attributes }, as: :turbo_stream
          expect(response).to(redirect_to(real_estate_url(real_estate)))
        end
      end

      it "returns forbidden" do
        patch real_estate_url(real_estate), params: { real_estate: new_attributes }
        expect(response).to(have_http_status(:forbidden))
      end
    end

    context "with invalid parameters" do
      context "owner" do
        let(:role) { "owner" }

        it "renders a response with 422 status (i.e. to display the 'edit' template)" do
          patch real_estate_url(real_estate), params: { real_estate: invalid_attributes }
          expect(response).to(have_http_status(:unprocessable_entity))
        end
      end

      it "returns forbidden" do
        patch real_estate_url(real_estate), params: { real_estate: invalid_attributes }
        expect(response).to(have_http_status(:forbidden))
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:real_estate) { FactoryBot.create(:real_estate, membership: membership) }

    context "owner" do
      let(:role) { "owner" }

      it "destroys the requested real_estate" do
        expect do
          delete(real_estate_url(real_estate))
        end.to(change(
          RealEstate,
          :count,
        ).by(-1).and(change(Membership, :count).by(-1).and(change(Collection, :count).by(-1))))
      end

      it "redirects to the real_estates list" do
        delete real_estate_url(real_estate)
        expect(response).to(redirect_to(real_estates_url))
      end
    end

    it "returns forbidden with viewer" do
      delete real_estate_url(real_estate)
      expect(response).to(have_http_status(:forbidden))
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe("LivingUnits", type: :request) do
  let(:user) { FactoryBot.create(:user) }

  let(:role) { "viewer" }
  let(:membership) { FactoryBot.build(:membership, user: user, role: role) }
  let(:real_estate) { FactoryBot.create(:real_estate, membership: membership) }
  let(:living_unit) { FactoryBot.create(:living_unit, real_estate:) }

  let(:invalid_attributes) do
    { name: "" }
  end

  before do
    sign_in(user)
  end

  describe "GET /show" do
    it "renders a successful response" do
      get real_estate_living_unit_url(real_estate, living_unit)
      expect(response).to(be_successful)
    end
  end

  describe "GET /edit" do
    context "owner" do
      let(:role) { "owner" }

      it "renders a successful response" do
        get edit_real_estate_living_unit_url(real_estate, living_unit)
        expect(response).to(be_successful)
      end
    end

    it "returns forbidden" do
      get edit_real_estate_living_unit_url(real_estate, living_unit)
      expect(response).to(have_http_status(:forbidden))
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new LivingUnit" do
        expect do
          post(real_estate_living_units_url(real_estate), params: {})
        end.to(change(
          LivingUnit,
          :count,
        ).by(1))
      end

      it "redirects to the created real_estate" do
        post real_estate_living_units_url(real_estate), params: {}
        expect(response).to(redirect_to(real_estate_living_unit_url(real_estate, LivingUnit.last)))
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

        it "updates the requested LivingUnit" do
          patch real_estate_living_unit_url(real_estate, living_unit), params: { living_unit: new_attributes }
          expect do
            living_unit.reload
          end.to(change(living_unit, :name).from("Untitled").to("Updated Name"))
        end

        it "redirects to the LivingUnit" do
          patch real_estate_living_unit_url(real_estate, living_unit), params: { living_unit: new_attributes }
          expect(response).to(redirect_to(real_estate_living_unit_url(real_estate, living_unit)))
        end
      end

      it "returns forbidden" do
        patch real_estate_living_unit_url(real_estate, living_unit), params: { living_unit: new_attributes }
        expect(response).to(have_http_status(:forbidden))
      end
    end

    context "with invalid parameters" do
      context "owner" do
        let(:role) { "owner" }

        it "renders a response with 422 status (i.e. to display the 'edit' template)" do
          patch real_estate_living_unit_url(real_estate, living_unit), params: { living_unit: invalid_attributes }
          expect(response).to(have_http_status(:unprocessable_entity))
        end
      end

      it "returns forbidden" do
        patch real_estate_living_unit_url(real_estate, living_unit), params: { living_unit: invalid_attributes }
        expect(response).to(have_http_status(:forbidden))
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:living_unit) { FactoryBot.create(:living_unit, real_estate:) }

    context "owner" do
      let(:role) { "owner" }

      it "destroys the requested LivingUnit" do
        expect do
          delete(real_estate_living_unit_url(real_estate, living_unit))
        end.to(change(
          LivingUnit,
          :count,
        ).by(-1))
      end

      it "redirects to the real_estates list" do
        delete real_estate_living_unit_url(real_estate, living_unit)
        expect(response).to(redirect_to(real_estate_url(real_estate)))
      end
    end

    it "returns forbidden with viewer" do
      delete real_estate_living_unit_url(real_estate, living_unit)
      expect(response).to(have_http_status(:forbidden))
    end
  end
end

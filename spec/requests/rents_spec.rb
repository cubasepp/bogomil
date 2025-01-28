# frozen_string_literal: true

require "rails_helper"

RSpec.describe("Rents", type: :request) do
  let(:user) { FactoryBot.create(:user) }

  let(:role) { "viewer" }
  let(:membership) { FactoryBot.build(:membership, user: user, role: role) }
  let(:real_estate) { FactoryBot.build(:real_estate, membership: membership) }
  let(:living_unit) { FactoryBot.create(:living_unit, real_estate:, rents: []) }
  # let(:rent) { FactoryBot.create(:rent, living_unit:) }

  let(:valid_attributes) do
    {
      cold_rent: "2000",
      heating_consts: "200",
      incidential_costs: "100",
      rent_type: "normal",
      valid_from: "01-04-2025",
    }
  end

  let(:invalid_attributes) do
    { cold_rent: "two" }
  end

  before do
    sign_in(user)
  end

  describe "GET /" do
    context "owner" do
      it "renders a successful response" do
        get living_unit_rents_url(living_unit)
        expect(response).to(be_successful)
      end
    end
  end

  describe "GET /new" do
    context "owner" do
      it "renders a successful response" do
        get new_living_unit_rent_url(living_unit)
        expect(response).to(be_successful)
      end
    end
  end

  describe "POST /create" do
    it "forbidden" do
      post(living_unit_rents_url(living_unit), params: { rent: valid_attributes })
      expect(response).to(have_http_status(:forbidden))
    end

    context "owner" do
      let(:role) { "owner" }
      context "with valid parameters" do
        it "creates a new Rent" do
          expect do
            post(living_unit_rents_url(living_unit), params: { rent: valid_attributes })
          end.to(change(
            Rent,
            :count,
          ).by(1))
        end

        it "redirects to the Rents page" do
          post(living_unit_rents_url(living_unit), params: { rent: valid_attributes })
          expect(response).to(redirect_to(living_unit_rents_url(living_unit)))
        end

        it "renders as turbo_stream response" do
          post living_unit_rents_url(living_unit), params: { rent: valid_attributes }, as: :turbo_stream
          expect(response).to(have_http_status(:ok))
          expect(response.body).to(match(/action="replace" target="main_content"/))
        end
      end

      context "with invalid parameters" do
        it "does not create a new Rent" do
          expect do
            post(living_unit_rents_url(living_unit), params: { rent: invalid_attributes })
          end.not_to(change(
            Rent,
            :count,
          ))
        end

        it "renders a response with 422 status (i.e. to display the 'new' template)" do
          post living_unit_rents_url(living_unit), params: { rent: invalid_attributes }
          expect(response).to(have_http_status(:unprocessable_entity))
        end
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:rent) { FactoryBot.create(:rent, living_unit:) }

    context "owner" do
      let(:role) { "owner" }

      it "destroys the requested Rent" do
        expect do
          delete(living_unit_rent_url(living_unit, rent))
        end.to(change(
          Rent,
          :count,
        ).by(-1))
      end

      it "redirects to the Rents list" do
        delete living_unit_rent_url(living_unit, rent)
        expect(response).to(redirect_to(living_unit_rents_url))
      end

      it "renders as turbo_stream response" do
        delete living_unit_rent_url(living_unit, rent), as: :turbo_stream
        expect(response).to(have_http_status(:ok))
        expect(response.body).to(match(/action="remove" target="rent_#{rent.id}"/))
      end
    end

    it "returns forbidden with viewer" do
      delete living_unit_rent_url(living_unit, rent)
      expect(response).to(have_http_status(:forbidden))
    end
  end
end

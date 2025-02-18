# frozen_string_literal: true

require "rails_helper"

RSpec.describe("LivingUnits", type: :request) do
  let(:user) { FactoryBot.create(:user) }
  let(:role) { "viewer" }
  let(:membership) { FactoryBot.build(:membership, user: user, role: role) }
  let(:real_estate) { FactoryBot.create(:real_estate, membership: membership) }
  let(:living_unit) { FactoryBot.create(:living_unit, real_estate:) }

  let(:valid_attributes) do
    { name: "Test Living Unit" }
  end

  let(:invalid_attributes) do
    { name: "" }
  end

  let(:new_attributes) do
    { name: "Updated Name" }
  end

  before do
    sign_in(user)
  end

  describe "GET /show" do
    it "succeeds" do
      get real_estate_living_unit_url(real_estate, living_unit)
      expect(response).to(be_successful)
    end
  end

  describe "GET /edit" do
    context "as owner" do
      let(:role) { "owner" }

      it "succeeds" do
        get edit_real_estate_living_unit_url(real_estate, living_unit)
        expect(response).to(be_successful)
      end
    end
  end

  describe "POST /create" do
    context "as owner" do
      let(:role) { "owner" }

      context "with valid params" do
        it "creates a new living unit" do
          expect do
            post(real_estate_living_units_url(real_estate), params: { living_unit: valid_attributes })
          end.to(change(LivingUnit, :count).by(1))
        end

        it "redirects to the living unit" do
          post real_estate_living_units_url(real_estate), params: { living_unit: valid_attributes }
          expect(response).to(redirect_to(real_estate_living_unit_url(real_estate, LivingUnit.last)))
        end
      end
    end

    context "as viewer" do
      it "is forbidden" do
        post real_estate_living_units_url(real_estate), params: { living_unit: valid_attributes }
        expect(response).to(have_http_status(:forbidden))
      end
    end
  end

  describe "PATCH /update" do
    context "as owner" do
      let(:role) { "owner" }

      context "with valid params" do
        it "updates the living unit" do
          patch real_estate_living_unit_url(real_estate, living_unit), params: { living_unit: new_attributes }
          living_unit.reload
          expect(living_unit.name).to(eq("Updated Name"))
        end

        it "redirects to the living unit" do
          patch real_estate_living_unit_url(real_estate, living_unit), params: { living_unit: new_attributes }
          expect(response).to(redirect_to(real_estate_living_unit_url(real_estate, living_unit)))
        end
      end

      context "with invalid params" do
        it "returns unprocessable entity status" do
          patch real_estate_living_unit_url(real_estate, living_unit), params: { living_unit: invalid_attributes }
          expect(response).to(have_http_status(:unprocessable_entity))
        end
      end
    end

    context "as viewer" do
      it "is forbidden" do
        patch real_estate_living_unit_url(real_estate, living_unit), params: { living_unit: new_attributes }
        expect(response).to(have_http_status(:forbidden))
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:living_unit) { FactoryBot.create(:living_unit, real_estate:) }

    context "as owner" do
      let(:role) { "owner" }

      it "deletes the living unit" do
        expect do
          delete(real_estate_living_unit_url(real_estate, living_unit))
        end.to(change(LivingUnit, :count).by(-1))
      end

      it "redirects to the real estate" do
        delete real_estate_living_unit_url(real_estate, living_unit)
        expect(response).to(redirect_to(real_estate_url(real_estate)))
      end
    end

    context "as viewer" do
      it "is forbidden" do
        delete real_estate_living_unit_url(real_estate, living_unit)
        expect(response).to(have_http_status(:forbidden))
      end
    end
  end
end

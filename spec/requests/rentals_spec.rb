# frozen_string_literal: true

require "rails_helper"

RSpec.describe("Rentals", type: :request) do
  let(:user) { FactoryBot.create(:user) }
  let(:role) { "viewer" }
  let(:membership) { FactoryBot.build(:membership, user: user, role: role) }
  let(:real_estate) { FactoryBot.create(:real_estate, membership: membership) }
  let(:living_unit) { FactoryBot.create(:living_unit, real_estate:) }
  let(:rental) { FactoryBot.create(:rental, living_unit:) }

  let(:valid_attributes) do
    {
      description: "Test Rental",
      valid_from: Date.current,
      tenants_attributes: [{
        first_name: "John",
        last_name: "Doe",
        email: "john@example.com",
        phone_number: "123456789",
      }],
      rents_attributes: [{
        cold_rent: 1000,
        heating_costs: 100,
        incidental_costs: 200,
        rent_type: "normal",
        valid_from: Date.current,
      }],
    }
  end

  let(:invalid_attributes) do
    { description: "", valid_from: nil }
  end

  let(:new_attributes) do
    { description: "Updated Description", valid_from: Date.tomorrow }
  end

  before do
    sign_in(user)
  end

  describe "GET /index" do
    it "succeeds" do
      rental # Create the rental
      get living_unit_rentals_url(living_unit)
      expect(response).to(be_successful)
    end
  end

  describe "GET /show" do
    it "succeeds" do
      get living_unit_rental_url(living_unit, rental)
      expect(response).to(be_successful)
    end
  end

  describe "GET /new" do
    it "succeeds" do
      get new_living_unit_rental_url(living_unit)
      expect(response).to(be_successful)
    end
  end

  describe "GET /edit" do
    context "as owner" do
      let(:role) { "owner" }

      it "succeeds" do
        get edit_living_unit_rental_url(living_unit, rental)
        expect(response).to(be_successful)
      end
    end
  end

  describe "POST /create" do
    context "as owner" do
      let(:role) { "owner" }

      context "with valid params" do
        it "creates a new rental" do
          expect do
            post(living_unit_rentals_url(living_unit), params: { rental: valid_attributes })
          end.to(change(Rental, :count).by(1))
        end

        it "redirects to rentals index" do
          post living_unit_rentals_url(living_unit), params: { rental: valid_attributes }
          expect(response).to(redirect_to(living_unit_rentals_url(living_unit)))
        end
      end

      context "with invalid params" do
        it "does not create a rental" do
          expect do
            post(living_unit_rentals_url(living_unit), params: { rental: invalid_attributes })
          end.not_to(change(Rental, :count))
        end

        it "returns unprocessable entity status" do
          post living_unit_rentals_url(living_unit), params: { rental: invalid_attributes }
          expect(response).to(have_http_status(:unprocessable_entity))
        end
      end
    end

    context "as viewer" do
      it "is forbidden" do
        post living_unit_rentals_url(living_unit), params: { rental: valid_attributes }
        expect(response).to(have_http_status(:forbidden))
      end
    end
  end

  describe "PATCH /update" do
    context "as owner" do
      let(:role) { "owner" }

      context "with valid params" do
        it "updates the rental" do
          patch living_unit_rental_url(living_unit, rental), params: { rental: new_attributes }
          rental.reload
          expect(rental.description).to(eq("Updated Description"))
          expect(rental.valid_from).to(eq(Date.tomorrow))
        end

        it "redirects to the rental" do
          patch living_unit_rental_url(living_unit, rental), params: { rental: new_attributes }
          expect(response).to(redirect_to(living_unit_rental_url(living_unit, rental)))
        end
      end

      context "with invalid params" do
        it "returns unprocessable entity status" do
          patch living_unit_rental_url(living_unit, rental), params: { rental: invalid_attributes }
          expect(response).to(have_http_status(:unprocessable_entity))
        end
      end
    end

    context "as viewer" do
      it "is forbidden" do
        patch living_unit_rental_url(living_unit, rental), params: { rental: new_attributes }
        expect(response).to(have_http_status(:forbidden))
      end
    end
  end

  describe "DELETE /destroy" do
    context "as owner" do
      let(:role) { "owner" }
      let!(:rental_to_delete) { FactoryBot.create(:rental, living_unit:) }

      it "archives the rental" do
        expect do
          delete(living_unit_rental_url(living_unit, rental_to_delete))
          rental_to_delete.reload
        end.to(change(rental_to_delete, :archived?).from(false).to(true))
      end

      context "with HTML format" do
        it "redirects to rentals index" do
          delete living_unit_rental_url(living_unit, rental_to_delete)
          expect(response).to(redirect_to(living_unit_rentals_url(living_unit)))
          expect(response).to(have_http_status(:see_other))
        end
      end

      context "with Turbo Stream format" do
        it "succeeds" do
          delete living_unit_rental_url(living_unit, rental_to_delete), as: :turbo_stream
          expect(response).to(be_successful)
        end
      end
    end

    context "as viewer" do
      it "is forbidden" do
        delete living_unit_rental_url(living_unit, rental)
        expect(response).to(have_http_status(:forbidden))
      end
    end
  end
end

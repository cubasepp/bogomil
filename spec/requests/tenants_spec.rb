# frozen_string_literal: true

require "rails_helper"

RSpec.describe("Tenants", type: :request) do
  let(:user) { FactoryBot.create(:user) }

  let(:role) { "viewer" }
  let(:membership) { FactoryBot.build(:membership, user: user, role: role) }
  let(:real_estate) { FactoryBot.build(:real_estate, membership: membership) }
  let(:living_unit) { FactoryBot.create(:living_unit, real_estate:, tenants: []) }

  let(:valid_attributes) do
    {
      "first_name": "Max",
      "last_name": "Mustermann",
      "email": "max.mustermann@bogomil.io",
      "phone_number": "01704104444",
    }
  end

  let(:invalid_attributes) do
    {
      "first_name": "",
      "last_name": "",
      "email": "",
      "phone_number": "",
    }
  end

  before do
    sign_in(user)
  end

  describe "GET /" do
    context "owner" do
      it "renders a successful response" do
        get living_unit_tenants_url(living_unit)
        expect(response).to(be_successful)
      end
    end
  end

  describe "GET /new" do
    context "owner" do
      it "renders a successful response" do
        get new_living_unit_tenant_url(living_unit)
        expect(response).to(be_successful)
      end
    end
  end

  describe "POST /create" do
    it "forbidden" do
      post(living_unit_tenants_url(living_unit), params: { tenant: valid_attributes })
      expect(response).to(have_http_status(:forbidden))
    end

    context "owner" do
      let(:role) { "owner" }
      context "with valid parameters" do
        it "creates a new Tenant" do
          expect do
            post(living_unit_tenants_url(living_unit), params: { tenant: valid_attributes })
          end.to(change(
            Tenant,
            :count,
          ).by(1))
        end

        it "redirects to the Tenants page" do
          post(living_unit_tenants_url(living_unit), params: { tenant: valid_attributes })
          expect(response).to(redirect_to(living_unit_tenants_url(living_unit)))
        end

        it "renders as turbo_stream response" do
          post living_unit_tenants_url(living_unit), params: { tenant: valid_attributes }, as: :turbo_stream
          expect(response).to(have_http_status(:ok))
          expect(response.body).to(match(/action="update" target="tenants"/))
        end
      end

      context "with invalid parameters" do
        it "does not create a new Tenant" do
          expect do
            post(living_unit_tenants_url(living_unit), params: { tenant: invalid_attributes })
          end.not_to(change(
            Tenant,
            :count,
          ))
        end

        it "renders a response with 422 status (i.e. to display the 'new' template)" do
          post living_unit_tenants_url(living_unit), params: { tenant: invalid_attributes }
          expect(response).to(have_http_status(:unprocessable_entity))
        end
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:tenant) { FactoryBot.create(:tenant, living_unit:) }

    context "owner" do
      let(:role) { "owner" }

      it "destroys the requested Tenant" do
        expect do
          delete(living_unit_tenant_url(living_unit, tenant))
        end.to(change(
          Tenant,
          :count,
        ).by(-1))
      end

      it "redirects to the Tenants list" do
        delete living_unit_tenant_url(living_unit, tenant)
        expect(response).to(redirect_to(living_unit_tenants_url))
      end

      it "renders as turbo_stream response" do
        delete living_unit_tenant_url(living_unit, tenant), as: :turbo_stream
        expect(response).to(have_http_status(:ok))
        expect(response.body).to(match(/action="remove" target="tenant_#{tenant.id}"/))
      end
    end

    it "returns forbidden with viewer" do
      delete living_unit_tenant_url(living_unit, tenant)
      expect(response).to(have_http_status(:forbidden))
    end
  end
end

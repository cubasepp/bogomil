# frozen_string_literal: true

require "rails_helper"

RSpec.describe("IndexRentCalculators", type: :request) do
  let(:user) { FactoryBot.create(:user) }
  before do
    sign_in(user)
  end

  describe "GET /calculator" do
    it "renders index" do
      get(index_rent_calculators_url)

      expect(response).to(have_http_status(:success))
    end
  end

  describe "GET /calculator/:id" do
    let(:consumer_index) { FactoryBot.create(:consumer_index) }
    let(:consumer_index_id) { consumer_index.id.join("-") }

    it "redirects an not turbo request" do
      get(
        index_rent_calculator_url(consumer_index_id),
      )
      expect(response).to(have_http_status(:redirect))
    end

    it "renders show" do
      get(
        index_rent_calculator_url(consumer_index_id),
        headers: { "turbo-frame" => :old_index },
      )
      expect(response).to(have_http_status(:success))
    end

    it "renders 404 not_found" do
      get(
        index_rent_calculator_url("1234"),
        headers: { "Turbo-Frame" => :old_index },
      )

      expect(response).to(have_http_status(:not_found))
    end
  end

  describe "POST /calculator/calculate" do
    context "valid input" do
      it "renders calculate as turbo_stream" do
        post(
          index_rent_calculators_url,
          params: { calculator: { old_index: "100.22", new_index: "102.22" } },
          as: :turbo_stream,
        )

        expect(response).to(have_http_status(:success))
      end
    end

    context "invalid input" do
      it "renders calculate as turbo_stream" do
        post(
          index_rent_calculators_url,
          params: { calculator: { old_index: "0", new_index: "Super" } },
          as: :turbo_stream,
        )

        expect(response).to(have_http_status(:success))
      end
    end
  end
end

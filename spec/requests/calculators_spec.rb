# frozen_string_literal: true

require "rails_helper"

RSpec.describe("Calculators", type: :request) do
  let(:user) { FactoryBot.create(:user) }
  before do
    sign_in(user)
  end

  describe "GET /calculator/" do
    it "renders show" do
      get(
        calculator_url,
      )
      expect(response).to(have_http_status(:success))
    end
  end

  describe "POST /calculator" do
    context "valid input" do
      it "renders calculate as turbo_stream" do
        post(
          calculator_url,
          params: { calculator: { old_index: "100.22", new_index: "102.22" } },
          as: :turbo_stream,
        )

        expect(response).to(have_http_status(:success))
      end
    end

    context "invalid input" do
      it "renders calculate as turbo_stream" do
        post(
          calculator_url,
          params: { calculator: { old_index: "0", new_index: "Super" } },
          as: :turbo_stream,
        )

        expect(response).to(have_http_status(:success))
      end
    end
  end
end

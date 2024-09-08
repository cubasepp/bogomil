# frozen_string_literal: true

require "rails_helper"

RSpec.describe("ConsumerIndcies", type: :request) do
  let(:user) { FactoryBot.create(:user) }
  before do
    sign_in(user)
  end

  describe "GET /consumer_indicies" do
    it "renders index" do
      get(consumer_indicies_url)

      expect(response).to(have_http_status(:success))
    end
  end

  describe "GET /consumer_indicies/:id" do
    let(:consumer_index) { FactoryBot.create(:consumer_index) }
    let(:consumer_index_id) { consumer_index.id.join("-") }

    it "renders show" do
      get(consumer_indicy_url(consumer_index_id))

      expect(response).to(have_http_status(:success))
    end

    it "renders 404 not_found" do
      get(consumer_indicy_url("1234"))

      expect(response).to(have_http_status(:not_found))
    end
  end

  describe "POST /consumer_indicies/calculate" do
    context "valid input" do
      it "renders calculate as turbo_stream" do
        post(
          calculates_consumer_indicies_url,
          params: { calculator: { old_index: "100.22", new_index: "102.22" } },
          as: :turbo_stream,
        )

        expect(response).to(have_http_status(:success))
      end
    end
    context "invalid input" do
      it "renders calculate as turbo_stream" do
        post(
          calculates_consumer_indicies_url,
          params: { calculator: { old_index: "0", new_index: "Super" } },
          as: :turbo_stream,
        )

        expect(response).to(have_http_status(:success))
      end
    end
  end
end

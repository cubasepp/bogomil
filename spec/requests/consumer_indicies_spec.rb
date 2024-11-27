# frozen_string_literal: true

require "rails_helper"

RSpec.describe("ConsumerIndicies", type: :request) do
  let(:user) { FactoryBot.create(:user) }
  let(:invalid_id) { "1970-01" }
  let(:consumer_index) { FactoryBot.create(:consumer_index, year: 2024) }

  before do
    sign_in(user)
  end

  describe "GET /consumer_indicies/#id" do
    it "renders show" do
      get(
        consumer_indicy_url(consumer_index.id_as_param),
      )
      expect(response).to(have_http_status(:success))
    end

    it "returns not_found" do
      get(
        consumer_indicy_url(consumer_index.id),
      )
      expect(response).to(have_http_status(:not_found))
    end
  end
end

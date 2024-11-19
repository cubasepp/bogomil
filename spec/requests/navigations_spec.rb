# frozen_string_literal: true

require "rails_helper"

RSpec.describe("Navigations", type: :request) do
  let(:user) { FactoryBot.create(:user) }
  before do
    sign_in(user)
  end

  describe "GET /navigation" do
    it "returns http success" do
      get navigation_url
      expect(response).to(have_http_status(:success))
    end
  end
end

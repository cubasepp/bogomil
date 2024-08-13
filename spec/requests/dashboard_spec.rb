# frozen_string_literal: true

require "rails_helper"

RSpec.describe("Dashboards", type: :request) do
  describe "GET /index" do
    it "returns http unauthorized" do
      get "/"
      expect(response).to(redirect_to(new_session_path))
    end

    it "returns http success" do
      user = FactoryBot.create(:user)
      sign_in(user)

      get "/"
      expect(response).to(have_http_status(:success))
    end
  end
end

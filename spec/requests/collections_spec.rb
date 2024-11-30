# frozen_string_literal: true

require "rails_helper"

RSpec.describe("/collections", type: :request) do
  let(:user) { FactoryBot.create(:user) }
  let(:collections) { FactoryBot.build_list(:collection, 3) }

  before do
    sign_in(user)
  end

  describe "GET /index" do
    it "renders a successful response" do
      get collections_url
      expect(response).to(be_successful)
    end
  end
end

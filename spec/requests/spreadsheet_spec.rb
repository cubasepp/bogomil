# frozen_string_literal: true

require "rails_helper"

RSpec.describe("Spreadsheets", type: :request) do
  let(:user) { FactoryBot.create(:user) }
  before do
    FactoryBot.create_list(:financesheet, 2, user:)
    sign_in(user)
  end

  describe "GET /spreadsheets" do
    it "renders index" do
      get(spreadsheets_url)

      expect(response).to(have_http_status(:success))
      assert_select("caption", text: "Spreadsheets:")
      assert_select("tbody>tr", 2)
    end
  end

  describe "POST /spreadsheets" do
    it "create an entry" do
      expect do
        post(spreadsheets_url, params: {
          spreadsheet: { name: "New sheet", description: "XX", type: "Financesheet" },
        })

        expect(response).to(have_http_status(:redirect))
        follow_redirect!

        assert_select("h1", text: "TBD:")
      end.to(change(user.reload.spreadsheets, :count).by(1))
    end
  end

  describe "DESTROY /spreadsheets/<id>" do
    it "create an entry" do
      expect do
        delete(spreadsheet_url(user.spreadsheets.first))
        expect(response).to(have_http_status(:redirect))
        follow_redirect!

        assert_select("caption", text: "Spreadsheets:")
        assert_select("tbody>tr", 1)
      end.to(change(user.reload.spreadsheets, :count).by(-1))
    end
  end
end

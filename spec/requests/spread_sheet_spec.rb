# frozen_string_literal: true

require "rails_helper"

RSpec.describe("SpreadSheets", type: :request) do
  let(:user) { FactoryBot.create(:user) }
  before do
    FactoryBot.create_list(:finance_sheet, 2, user:)
    sign_in(user)
  end

  describe "GET /spread_sheets" do
    it "renders index" do
      get(spread_sheets_url)

      expect(response).to(have_http_status(:success))
      assert_select("caption", text: "Spreadsheets:")
      assert_select("tbody>tr", 2)
    end
  end

  describe "POST /spread_sheets" do
    it "create an entry" do
      expect do
        post(spread_sheets_url, params: {
          spread_sheet: { name: "New sheet", description: "XX", type: "FinanceSheet" },
        })

        expect(response).to(have_http_status(:redirect))
        follow_redirect!

        assert_select("h1", text: "TBD:")
      end.to(change(user.reload.spread_sheets, :count).by(1))
    end
  end

  describe "DESTROY /spread_sheets/<id>" do
    it "create an entry" do
      expect do
        delete(spread_sheet_url(user.spread_sheets.first))
        expect(response).to(have_http_status(:redirect))
        follow_redirect!

        assert_select("caption", text: "Spreadsheets:")
        assert_select("tbody>tr", 1)
      end.to(change(user.reload.spread_sheets, :count).by(-1))
    end
  end
end

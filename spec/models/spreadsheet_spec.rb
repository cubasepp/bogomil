# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Spreadsheet, type: :model) do
  context "associations" do
    should belong_to(:user)
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end

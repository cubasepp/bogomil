# frozen_string_literal: true

require "rails_helper"

RSpec.describe(SpreadSheet, type: :model) do
  describe "associations" do
    it { should belong_to(:user) }
    it { should have_delegated_type(:spread_sheetable).required }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end

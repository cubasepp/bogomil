# frozen_string_literal: true

RSpec.shared_examples("a spread sheetable") do
  describe "associations" do
    it { should have_one(:spread_sheet).required.dependent(:destroy).touch(true) }
  end
end

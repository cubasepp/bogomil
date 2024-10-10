# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Property, type: :model) do
  it_behaves_like "a spread sheetable"
end

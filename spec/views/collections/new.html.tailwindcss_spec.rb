# frozen_string_literal: true

require "rails_helper"

RSpec.describe("collections/new", type: :view) do
  include_examples "a main turbo_frame", "new_real_estate"
end

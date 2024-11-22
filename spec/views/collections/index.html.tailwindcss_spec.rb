# frozen_string_literal: true

require "rails_helper"

RSpec.describe("collections/index", type: :view) do
  include_examples "a turbo_frame", "wrapper_collection"
end

# frozen_string_literal: true

RSpec.configure do |config|
  config.include(Helpers::Session, type: :request)
end

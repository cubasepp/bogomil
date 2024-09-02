# frozen_string_literal: true

require "config_builder"

module AppConfig
  extend ConfigBuilder

  setting :destatis_setting, type: :hash, default: "{}"
end

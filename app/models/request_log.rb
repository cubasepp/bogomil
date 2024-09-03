# frozen_string_literal: true

class RequestLog < ApplicationRecord
  normalizes :data, :body, with: -> { _1.force_encoding("iso-8859-1").encode("utf-8") }
end

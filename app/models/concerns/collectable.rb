# frozen_string_literal: true

module Collectable
  extend ActiveSupport::Concern

  included do
    has_one :collection, as: :collectable, required: true, touch: true, dependent: :destroy

    after_initialize :ensure_collection, if: :new_record?
  end

  private

  def ensure_collection
    self.collection ||= build_collection
  end
end

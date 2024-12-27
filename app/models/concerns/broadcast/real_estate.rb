# frozen_string_literal: true

module Broadcast
  module RealEstate
    extend ActiveSupport::Concern

    included do
      after_update_commit do
        broadcast_update_to(
          :events,
          target: "edit_real_estate_#{id}",
          partial: "real_estates/form",
          locals: { disabled: true, real_estate: self },
        )
      end
    end
  end
end

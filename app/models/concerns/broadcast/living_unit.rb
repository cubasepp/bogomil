# frozen_string_literal: true

module Broadcast
  module LivingUnit
    extend ActiveSupport::Concern

    included do
      after_update_commit do
        broadcast_update_later_to(:events, target: "name_living_unit_#{id}", html: name)
        broadcast_replace_later_to(
          :events,
          target: "edit_living_unit_#{id}",
          partial: "living_units/form",
          locals: { disabled: true, real_estate: real_estate, living_unit: self },
        )
      end
      after_create_commit do
        broadcast_append_later_to(
          :events,
          target: "sidebar_childrens_collection_#{real_estate_id}",
          partial: "collections/childrens",
          locals: { collection: real_estate, living_unit: self },
        )
      end
      after_destroy_commit do
        broadcast_remove_to(:events, target: "sidebar_living_unit_#{id}")
      end
    end
  end
end

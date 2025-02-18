# frozen_string_literal: true

module Broadcast
  module Rental
    extend ActiveSupport::Concern

    included do
      after_update_commit do
        if archived?
          broadcast_remove_to(
            :events,
            target: "index_rental_#{id}",
          )
          broadcast_prepend_later_to(
            :events,
            target: "archived_rentals_living_unit_#{living_unit_id}",
            partial: "rentals/rental",
            locals: { rental: self, living_unit: living_unit },
          )
        else
          broadcast_update_later_to(
            :events,
            target: "edit_rental_#{id}",
            partial: "rentals/form",
            locals: { rental: self, living_unit: living_unit, disabled: true },
          )
          broadcast_update_later_to(
            :events,
            target: "index_rental_#{id}",
            partial: "rentals/rental",
            locals: { rental: self, living_unit: living_unit },
          )
        end
      end

      after_create_commit do
        broadcast_prepend_later_to(
          :events,
          target: "active_rentals_living_unit_#{living_unit_id}",
          partial: "rentals/rental",
          locals: { rental: self, living_unit: living_unit },
        )
      end
    end
  end
end

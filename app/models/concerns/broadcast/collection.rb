# frozen_string_literal: true

module Broadcast
  module Collection
    extend ActiveSupport::Concern

    included do
      after_create_commit do
        broadcast_append_later_to(:events, target: :sidebar_list)
      end
      after_update_commit do
        broadcast_update_later_to(:events, target: "name_collection_#{id}", html: name)
        broadcast_replace_later_to(
          Current.user,
          :sidebar,
          target: "sidebar_collection_#{id}",
          locals: {
            user: Current.user,
          },
        )
      end
      after_destroy_commit do
        broadcast_remove_to(:events, target: "sidebar_collection_#{id}")
      end
    end
  end
end

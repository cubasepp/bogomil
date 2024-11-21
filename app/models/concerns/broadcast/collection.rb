# frozen_string_literal: true

module Broadcast
  module Collection
    extend ActiveSupport::Concern

    included do
      after_create_commit do
        broadcast_render_to(:sidebar, partial: "layouts/sidebar/create", locals: { collection: self })
      end
      after_update_commit do
        broadcast_render_to(:sidebar, partial: "layouts/sidebar/update", locals: { collection: self })
      end
      after_destroy_commit do
        broadcast_render_to(:sidebar, partial: "layouts/sidebar/destroy", locals: { collection: self })
      end
    end
  end
end

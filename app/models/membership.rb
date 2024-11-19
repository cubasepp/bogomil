# frozen_string_literal: true

class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :memberable, polymorphic: true

  enum :role, ["owner", "viewer"].index_by(&:itself), default: :owner
end

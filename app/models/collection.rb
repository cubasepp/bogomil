# frozen_string_literal: true

class Collection < ApplicationRecord
  include Broadcast::Collection

  delegated_type :collectable, types: ["RealEstate"]
  delegate :name, to: :collectable

  has_many :memberships,
    foreign_key: [:memberable_type, :memberable_id],
    primary_key: [:collectable_type, :collectable_id],
    inverse_of: "user",
    dependent: nil

  class << self
    def accessable(user: Current.user)
      joins(:memberships).where(memberships: { user: })
    end
  end

  def open
    false
  end
end

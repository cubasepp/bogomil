# frozen_string_literal: true

class Collection < ApplicationRecord
  include Broadcast::Collection

  delegated_type :collectable, types: ["RealEstate"]
  delegate :name, to: :collectable
  store :user_settings, accessors: [:collapse], coder: JSON

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

  def collapsed_for?(user: Current.user)
    collapse&.include?(user&.id)
  end

  def collapse
    super || []
  end

  def toggle_collapse!(user: Current.user)
    return if user.nil?

    self.collapse = if collapse.include?(user.id)
      collapse.reject! { |user_id| user_id == user.id }
    else
      collapse << user.id
    end
    save!
  end
end

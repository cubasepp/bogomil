# frozen_string_literal: true

module Memberable
  extend ActiveSupport::Concern

  included do
    has_one :membership, as: :memberable, required: true, touch: true, dependent: :destroy
    has_many :memberships, as: :memberable, dependent: :destroy
    has_many :users, through: :memberships

    after_initialize :ensure_membership, if: :new_record?
  end

  class_methods do
    def accessable(user: Current.user)
      user.public_send(model_name.collection)
    end
  end

  def can_manage?(user: Current.user)
    memberships_for&.owner?
  end

  def memberships_for(user: Current.user)
    memberships.find_by(user:)
  end

  private

  def ensure_membership
    self.membership ||= build_membership(user: Current.user)
  end
end

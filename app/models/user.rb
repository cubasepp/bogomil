# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :memberships, dependent: :destroy
  has_many :real_estates, through: :memberships, source: :memberable, source_type: "RealEstate"

  validates :email, presence: true, uniqueness: true

  scope :active, -> { where(deactived_at: nil) }
end

# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :spread_sheets, dependent: :destroy

  validates :email, presence: true, uniqueness: true

  scope :active, -> { where(deactived_at: nil) }
end

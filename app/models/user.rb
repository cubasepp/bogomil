class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  scope :active, -> { where(deactived_at: nil) }
end

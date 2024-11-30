# frozen_string_literal: true

require "rails_helper"

RSpec.describe(User, type: :model) do
  describe "associations" do
    it { should have_many(:memberships).dependent(:destroy) }
    it { should have_many(:real_estates).through(:memberships).source(:memberable) }
  end

  describe "validations" do
    it { should have_secure_password }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end
end

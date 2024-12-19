# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Collection, type: :model) do
  describe "associations" do
    it { should have_delegated_type(:collectable) }
    it { should have_many(:memberships).inverse_of("user") }
  end

  describe "toggle_collapse!" do
    let(:user) { FactoryBot.build_stubbed(:user, id: 1001) }
    let!(:collection) { FactoryBot.create(:collection) }

    it "toggle set/unset the user id" do
      expect do
        collection.toggle_collapse!(user: user)
      end.to(change(collection.reload, :collapse).from([]).to([1001]))

      expect do
        collection.toggle_collapse!(user: user)
        collection.save!
      end.to(change(collection.reload, :collapse).from([1001]).to([]))
    end
  end
end

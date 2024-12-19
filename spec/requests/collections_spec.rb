# frozen_string_literal: true

require "rails_helper"

RSpec.describe("/collections", type: :request) do
  let(:user) { FactoryBot.create(:user) }
  let(:collections) { FactoryBot.build_list(:collection, 3) }

  before do
    sign_in(user)
  end

  describe "GET /collections" do
    it "renders a successful response" do
      get collections_url
      expect(response).to(be_successful)
    end
  end

  describe "GET /collections/new" do
    it "renders a successful response" do
      get new_collection_url
      expect(response).to(be_successful)
    end
  end

  describe "PATCH /collections/" do
    let(:membership) { FactoryBot.build(:membership, user:) }
    let(:real_estate) { FactoryBot.build(:real_estate, membership:) }
    let!(:collection) { FactoryBot.create(:collection, collectable: real_estate) }

    it "redirects to root path" do
      patch collection_url(collection)
      expect(response).to(redirect_to(root_path))
    end

    it "set collapse/uncollapse to current user" do
      expect do
        patch(collection_url(collection))
        collection.reload
      end.to(change(collection, :collapse).from([]).to([1]))

      expect do
        patch(collection_url(collection))
        collection.reload
      end.to(change(collection, :collapse).from([1]).to([]))
    end
  end
end

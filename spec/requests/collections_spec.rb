# frozen_string_literal: true

require "rails_helper"

RSpec.describe("/collections", type: :request) do
  let(:role) { "viewer" }
  let(:user) { FactoryBot.create(:user) }
  let(:membership) { FactoryBot.build(:membership, user: user, role: role) }
  let(:collection) { FactoryBot.create(:collection, name: "Super Demo", membership: membership) }

  let(:valid_attributes) do
    { name: "demo" }
  end

  let(:invalid_attributes) do
    { name: "" }
  end

  before do
    sign_in(user)
  end

  describe "GET /index" do
    it "renders a successful response" do
      get collections_url
      expect(response).to(be_successful)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get collection_url(collection)
      expect(response).to(be_successful)
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_collection_url
      expect(response).to(be_successful)
    end
  end

  describe "GET /edit" do
    context "owner" do
      let(:role) { "owner" }

      it "renders a successful response" do
        get edit_collection_url(collection)
        expect(response).to(be_successful)
      end
    end

    it "returns forbidden" do
      get edit_collection_url(collection)
      expect(response).to(have_http_status(:forbidden))
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Collection" do
        expect do
          post(collections_url, params: { collection: valid_attributes })
        end.to(change(Collection, :count).by(1).and(change(Membership, :count).by(1)))
      end

      it "redirects to the created collection" do
        post collections_url, params: { collection: valid_attributes }
        expect(response).to(redirect_to(collection_url(Collection.last)))
      end
      it "redirects to create_collection as turbo_stream" do
        post collections_url, params: { collection: valid_attributes }, as: :turbo_stream
        expect(response).to(have_http_status(:ok))
        expect(response.body).to(match(/action="replace" target="wrapper_collection"/))
      end

      it "creates a owner membership" do
        post collections_url, params: { collection: valid_attributes }
        expect(Membership.last.owner?).to(be_truthy)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Collection" do
        expect do
          post(collections_url, params: { collection: invalid_attributes })
        end.to(change(Collection, :count).by(0).and(change(Membership, :count).by(0)))
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post collections_url, params: { collection: invalid_attributes }
        expect(response).to(have_http_status(:unprocessable_entity))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { name: "Updated Name" }
      end

      context "owner" do
        let(:role) { "owner" }

        it "updates the requested collection" do
          patch collection_url(collection), params: { collection: new_attributes }
          expect do
            collection.reload
          end.to(change(collection, :name).from("Super Demo").to("Updated Name"))
        end

        it "redirects to the collection" do
          patch collection_url(collection), params: { collection: new_attributes }
          expect(response).to(redirect_to(collection_url(collection)))
        end

        it "redirects to the collection at trubo_stream" do
          patch collection_url(collection), params: { collection: new_attributes }, as: :turbo_stream
          expect(response).to(redirect_to(collection_url(collection)))
        end
      end

      it "returns forbidden" do
        patch collection_url(collection), params: { collection: new_attributes }
        expect(response).to(have_http_status(:forbidden))
      end
    end

    context "with invalid parameters" do
      context "owner" do
        let(:role) { "owner" }

        it "renders a response with 422 status (i.e. to display the 'edit' template)" do
          patch collection_url(collection), params: { collection: invalid_attributes }
          expect(response).to(have_http_status(:unprocessable_entity))
        end
      end

      it "returns forbidden" do
        patch collection_url(collection), params: { collection: invalid_attributes }
        expect(response).to(have_http_status(:forbidden))
      end
    end
  end

  describe "DELETE /destroy" do
    context "owner" do
      let!(:collection) { FactoryBot.create(:collection, membership: membership) }
      let(:role) { "owner" }

      it "destroys the requested collection" do
        expect do
          delete(collection_url(collection))
        end.to(change(Collection, :count).by(-1))
      end

      it "redirects to the collections list" do
        delete collection_url(collection)
        expect(response).to(redirect_to(collections_url))
      end
    end

    it "returns forbidden with viewer" do
      delete collection_url(collection)
      expect(response).to(have_http_status(:forbidden))
    end
  end
end

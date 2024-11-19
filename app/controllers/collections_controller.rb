# frozen_string_literal: true

class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]
  before_action :can_manage?, only: [:edit, :update, :destroy]

  def index
    @collections = Collection.accessable
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def show
  end

  def new
    @collection = Collection.new

    respond_to do |format|
      format.turbo_stream do
        render(
          turbo_stream: turbo_stream.update(
            "quick_menu",
            partial: "form",
            locals: { format: :turbo_stream },
          ),
        )
      end
      format.html
    end
  end

  def edit
  end

  def create
    @collection = Collection.new(collection_params)

    respond_to do |format|
      if @collection.save
        format.turbo_stream do
          render(turbo_stream: turbo_stream.action(:redirect, collection_path(@collection)))
        end
        format.html { redirect_to(@collection, notice: "Collection was successfully created.") }
      else
        format.turbo_stream do
          render(
            turbo_stream: turbo_stream.update(
              "quick_menu",
              partial: "form",
              locals: { format: :turbo_stream },
            ),
          )
        end
        format.html { render(:new, status: :unprocessable_entity) }
      end
    end
  end

  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to(@collection, notice: "Collection was successfully updated.") }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
      end
    end
  end

  def destroy
    @collection.destroy!

    respond_to do |format|
      format.turbo_stream do
        render(turbo_stream: turbo_stream.action(:redirect, collections_path))
      end
      format.html do
        redirect_to(collections_path, status: :see_other, notice: "Collection was successfully destroyed.")
      end
    end
  end

  private

  def can_manage?
    head(:forbidden) unless @collection.can_manage?
  end

  def set_collection
    @collection = Collection.accessable.find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(:name)
  end
end

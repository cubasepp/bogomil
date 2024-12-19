# frozen_string_literal: true

class CollectionsController < ApplicationController
  def index
    @collections = Collection.accessable
    render(layout: false)
  end

  def new
  end

  def update
    @collection = Collection.accessable.find(params[:id])

    respond_to do |format|
      if @collection.toggle_collapse!
        format.turbo_stream
        format.html { redirect_to(root_path, notice: "Collection was successfull updated.") }
      end
    end
  end
end

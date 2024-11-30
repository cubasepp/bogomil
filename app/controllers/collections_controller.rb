# frozen_string_literal: true

class CollectionsController < ApplicationController
  def index
    @collections = Collection.accessable
    render(layout: false)
  end

  def new
  end
end

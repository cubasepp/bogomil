# frozen_string_literal: true

class ConsumerIndiciesController < ApplicationController
  def index
    @consumer_indicies = ConsumerIndex.order(year: :desc).all
  end

  def show
    @consumer_index = ConsumerIndex.find(params[:id]&.split("-"))
  end
end

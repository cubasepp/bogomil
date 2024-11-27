# frozen_string_literal: true

class ConsumerIndiciesController < ApplicationController
  def show
    @consumer_index = ConsumerIndex.find(params[:id]&.split("-"))

    respond_to do |format|
      format.html
    end
  end
end

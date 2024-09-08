# frozen_string_literal: true

class ConsumerIndiciesController < ApplicationController
  def index
    year = params[:start_year] = Date.current.years_ago(3).year
    @consumer_indicies = ConsumerIndex.where(year:)
  end

  def show
    @consumer_index = ConsumerIndex.find(params[id])
  end
end

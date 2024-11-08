# frozen_string_literal: true

class CalculatorsController < ApplicationController
  def show
    current_date = Date.current
    @current = ConsumerIndex.order(month: :desc).select(:year, :month).find_by(year: current_date.year)
    @prev_year = current_date.prev_year.year
    @min_year = ConsumerIndex.minimum(:year)
  end

  def create
    new_index = permitted_params[:new_index]
    old_index = permitted_params[:old_index]
    @percentage_points = (new_index - old_index).round(2)
    @percent = (((new_index / old_index) * 100 - 100)).round(2)
  end

  private

  def permitted_params
    @permitted_params = params.require(:calculator).permit(:old_index, :new_index)
      .transform_values { |v| v.to_f.nonzero? || 1.0 }
      .with_defaults(old_index: 1.0, new_index: 0.0)
  end
end

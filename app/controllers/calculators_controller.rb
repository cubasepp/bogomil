# frozen_string_literal: true

class CalculatorsController < ApplicationController
  def show
    @frames = [:old_index, :new_index]
    @end_year, @start_year = ConsumerIndex.select("MIN(year), MAX(year)").pick("MIN(year)", "MAX(year)")
    @incomplete_years = ConsumerIndex.select("year, MAX(month) as month").group(:year).having("month < 12").to_json
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

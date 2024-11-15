# frozen_string_literal: true

class CalculatorsController < ApplicationController
  def show
    @calculator_data = ConsumerIndex.order(month: :desc)
      .select(:year, :month)
      .find_by(year: Date.current.year)
      .then do |current_index|
        next if current_index.nil?

        old_index = ConsumerIndex
          .where
          .not(year: current_index.year)
          .select("max(year) as from_year, min(year) as to_year").first
        {
          new_index: {
            from: current_index.year,
            to: current_index.year,
            months: current_index.month,
          },
          old_index: {
            from: old_index.from_year,
            to: old_index.to_year,
            months: 12,
          },
        }
      end
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

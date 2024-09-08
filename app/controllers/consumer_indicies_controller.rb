# frozen_string_literal: true

class ConsumerIndiciesController < ApplicationController
  before_action { @frame_ids = [:old_index, :new_index] }

  def index
    @grouped_consumer_indicies = ConsumerIndex
      .order(:year)
      .group(:year)
      .maximum(:month)
      .group_by { |k, _v| k == Date.current.year ? :new_index : :old_index }
      .transform_values!(&:to_h)
  end

  def show
    @consumer_index = ConsumerIndex.find(params[:id].split("-"))
    @frame_id = params[:frame_id].try(:underscore).try(:to_sym)
  end

  def calculate
    @result = (((permitted_params[:new_index] / permitted_params[:old_index]) * 100 - 100)).round(2)
  end

  private

  def permitted_params
    @permitted_params = params.require(:calculator).permit(:old_index, :new_index)
      .transform_values! { |value| value.try(:to_f).then { |number| number.zero? ? 1.0 : number } }
      .with_defaults(old_index: 1.0, new_index: 0.0)
  end
end

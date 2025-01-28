# frozen_string_literal: true

class RentsController < ApplicationController
  before_action :set_real_estate_living_unit
  before_action :set_rent, only: [:destroy]
  before_action :can_manage?, only: [:create, :destroy]

  def index
    @rents = @living_unit.rents
  end

  def new
    @rent = Rent.new
  end

  def create
    @rent = @living_unit.rents.new(rent_params)

    respond_to do |format|
      if @rent.save
        format.turbo_stream
        format.html do
          redirect_to(living_unit_rents_path(@living_unit), notice: "Rent was successfully created.")
        end
      else
        format.html { render(:new, status: :unprocessable_entity) }
      end
    end
  end

  def destroy
    @rent.destroy!

    respond_to do |format|
      format.turbo_stream
      format.html do
        redirect_to(
          living_unit_rents_path(@living_unit),
          status: :see_other,
          notice: "Rent was successfully destroyed.",
        )
      end
    end
  end

  private

  def can_manage?
    head(:forbidden) unless @real_estate.can_manage?
  end

  def set_real_estate_living_unit
    @living_unit = LivingUnit.accessable.find(params[:living_unit_id]).tap do |living_unit|
      @real_estate = living_unit.real_estate
    end
  end

  def set_rent
    @rent = @living_unit.rents.find(params[:id])
  end

  def rent_params
    params.require(:rent).permit(
      :cold_rent,
      :heating_costs,
      :incidental_costs,
      :rent_type,
      :valid_from,
    )
  end
end

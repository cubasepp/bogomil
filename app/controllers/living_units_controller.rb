# frozen_string_literal: true

class LivingUnitsController < ApplicationController
  before_action :set_real_estate
  before_action :set_living_unit, only: [:show, :edit, :update, :destroy]
  before_action :can_manage?, only: [:edit, :update, :destroy]

  def show
  end

  def edit
  end

  def create
    @living_unit = @real_estate.living_units.new

    respond_to do |format|
      if @living_unit.save
        format.turbo_stream
        format.html { redirect_to([@real_estate, @living_unit], notice: "LivingUnit was successfully created.") }
      else
        format.html { render(:new, status: :unprocessable_entity) }
      end
    end
  end

  def update
    respond_to do |format|
      if @living_unit.update(living_unit_params)
        format.html { redirect_to([@real_estate, @living_unit], notice: "LivingUnit was successfully updated.") }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
      end
    end
  end

  def destroy
    @living_unit.destroy!

    respond_to do |format|
      format.html do
        redirect_to(
          real_estate_path(@real_estate),
          status: :see_other,
          notice: "LivingUnit was successfully destroyed.",
        )
      end
    end
  end

  private

  def can_manage?
    head(:forbidden) unless @real_estate.can_manage?
  end

  def set_real_estate
    @real_estate = RealEstate.accessable.find(params[:real_estate_id])
  end

  def set_living_unit
    @living_unit = @real_estate.living_units.find(params[:id])
  end

  def living_unit_params
    params.require(:living_unit).permit(
      :name,
      :description,
      :rooms,
      :living_space,
      :own_use,
    )
  end
end

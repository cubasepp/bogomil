# frozen_string_literal: true

class RentalsController < ApplicationController
  before_action :set_real_estate_living_unit
  before_action :set_rental, only: [:show, :update, :edit, :destroy]
  before_action :can_manage?, only: [:update, :create, :destroy]

  def index
    @rentals = @living_unit.rentals
  end

  def new
    @rental = Rental.new
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @rental.update(rental_params)
        format.turbo_stream do
          flash.now[:notice] = "Rental was successfully updated."
        end
        format.html do
          redirect_to(
            living_unit_rental_path(@living_unit, @rental),
            notice: "Rental was successfully updated.",
          )
        end
      else
        format.html { render(:edit, status: :unprocessable_entity) }
      end
    end
  end

  def create
    @rental = @living_unit.rentals.new(rental_params)
    respond_to do |format|
      if @rental.save
        format.html do
          redirect_to(
            living_unit_rentals_path(@living_unit),
            notice: "Rental was successfully created.",
          )
        end
      else
        format.html { render(:new, status: :unprocessable_entity) }
      end
    end
  end

  def destroy
    @rental.archive!

    respond_to do |format|
      format.turbo_stream
      format.html do
        redirect_to(
          living_unit_rentals_path(@living_unit),
          status: :see_other,
          notice: "Rental was successfully destroyed.",
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

  def set_rental
    @rental = @living_unit.rentals.find(params[:id])
  end

  def rental_params
    params.require(:rental).permit(
      :description,
      :valid_from,
      tenants_attributes: [
        :first_name,
        :last_name,
        :email,
        :phone_number,
      ],
      rents_attributes: [
        :cold_rent,
        :heating_costs,
        :incidental_costs,
        :rent_type,
        :valid_from,
      ],
    )
  end
end

# frozen_string_literal: true

class RealEstatesController < ApplicationController
  before_action :set_real_estate, only: [:show, :edit, :update, :destroy]
  before_action :can_manage?, only: [:edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @real_estate = RealEstate.new
  end

  def edit
  end

  def create
    @real_estate = RealEstate.new(real_estate_params)

    respond_to do |format|
      if @real_estate.save
        format.turbo_stream
        format.html { redirect_to(@real_estate, notice: "RealEstate was successfully created.") }
      else
        format.html { render(:new, status: :unprocessable_entity) }
      end
    end
  end

  def update
    respond_to do |format|
      if @real_estate.update(real_estate_params)
        format.html { redirect_to(@real_estate, notice: "RealEstate was successfully updated.") }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
      end
    end
  end

  def destroy
    @real_estate.destroy!

    respond_to do |format|
      format.html do
        redirect_to(real_estates_path, status: :see_other, notice: "RealEstate was successfully destroyed.")
      end
    end
  end

  private

  def can_manage?
    head(:forbidden) unless @real_estate.can_manage?
  end

  def set_real_estate
    @real_estate = RealEstate.accessable.find(params[:id])
  end

  def real_estate_params
    params.require(:real_estate).permit(:name, :street, :zip_code, :city, :rooms, :size)
  end
end

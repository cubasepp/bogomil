# frozen_string_literal: true

class TenantsController < ApplicationController
  before_action :set_real_estate_living_unit
  before_action :set_tenant, only: [:destroy]
  before_action :can_manage?, only: [:create, :destroy]

  def index
    @tenants = @living_unit.tenants
  end

  def new
    @tenant = Tenant.new
  end

  def create
    @tenant = @living_unit.tenants.new(tenant_params)

    respond_to do |format|
      if @tenant.save
        format.turbo_stream
        format.html do
          redirect_to(living_unit_tenants_path(@living_unit), notice: "Tenant was successfully created.")
        end
      else
        format.html { render(:new, status: :unprocessable_entity) }
      end
    end
  end

  def destroy
    @tenant.destroy!

    respond_to do |format|
      format.turbo_stream
      format.html do
        redirect_to(
          living_unit_tenants_path(@living_unit),
          status: :see_other,
          notice: "Tenant was successfully destroyed.",
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

  def set_tenant
    @tenant = @living_unit.tenants.find(params[:id])
  end

  def tenant_params
    params.require(:tenant).permit(
      :first_name,
      :last_name,
      :email,
      :phone_number,
    )
  end
end

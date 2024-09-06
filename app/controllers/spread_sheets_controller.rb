# frozen_string_literal: true

class SpreadSheetsController < ApplicationController
  before_action :set_spread_sheet, only: [:show, :update, :destroy]

  def index
    @spread_sheets = SpreadSheet.accessable
  end

  def show
  end

  def new
    @spread_sheet = SpreadSheet.new
  end

  def create
    @spread_sheet = SpreadSheet.for_type(permitted_params[:type])
      .new(permitted_params.except(:type)).tap do |sheet|
        sheet.user = Current.user
      end

    respond_to do |format|
      if @spread_sheet.save
        format.html { redirect_to(spread_sheet_url(@spread_sheet), notice: "SpreadSheet was successfully created.") }
        format.turbo_stream
      else
        format.html { render(:new, status: :unprocessable_entity) }
      end
    end
  end

  def update
    respond_to do |format|
      if @spread_sheet.update(permitted_params)
        format.html { redirect_to(spread_sheet_url(@spread_sheet), notice: "SpreadSheet was successfully updated.") }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
      end
    end
  end

  def destroy
    @spread_sheet.destroy!

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to(spread_sheets_url, notice: "SpreadSheet was successfully destroyed.") }
    end
  end

  private

  def set_spread_sheet
    @spread_sheet = SpreadSheet.accessable.find(params[:id])
  end

  def permitted_params
    params.require(:spread_sheet).permit(:name, :description, :type)
  end
end

# frozen_string_literal: true

class SpreadsheetsController < ApplicationController
  before_action :set_spreadsheet, only: [:show, :update, :destroy]

  def index
    @spreadsheets = Spreadsheet.accessable
  end

  def show
  end

  def new
    @spreadsheet = Spreadsheet.new
  end

  def create
    @spreadsheet = Spreadsheet.for_type(permitted_params[:type])
      .new(permitted_params.except(:type)).tap do |sheet|
        sheet.user = Current.user
      end

    respond_to do |format|
      if @spreadsheet.save
        format.html { redirect_to(spreadsheet_url(@spreadsheet), notice: "Spreadsheet was successfully created.") }
        format.turbo_stream
      else
        format.html { render(:new, status: :unprocessable_entity) }
      end
    end
  end

  def update
    respond_to do |format|
      if @spreadsheet.update(permitted_params)
        format.html { redirect_to(spreadsheet_url(@spreadsheet), notice: "Spreadsheet was successfully updated.") }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
      end
    end
  end

  def destroy
    @spreadsheet.destroy!

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to(spreadsheets_url, notice: "Spreadsheet was successfully destroyed.") }
    end
  end

  private

  def set_spreadsheet
    @spreadsheet = Spreadsheet.accessable.find(params[:id])
  end

  def permitted_params
    params.require(:spreadsheet).permit(:name, :description, :type)
  end
end

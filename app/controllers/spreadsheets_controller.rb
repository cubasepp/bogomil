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
    @spreadsheet = Spreadsheet.new(permitted_params).tap do |sheet|
      sheet.user = Current.user
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

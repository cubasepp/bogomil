# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authentication

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_found
    render("shared/not_found")
  end
end

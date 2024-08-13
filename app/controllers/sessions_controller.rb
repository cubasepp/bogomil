# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]

  def new
  end

  def create
    if (user = User.active.authenticate_by(email: params[:email], password: params[:password]))
      Current.user = user
      cookies.signed.permanent[:user_id] = { value: user.id, httponly: true, same_site: :lax }
      redirect_to(root_url)
    else
      flash[:alert] = I18n.t("errors.unauthorized")
      render(:new, status: :unauthorized)
    end
  end

  def destroy
    cookies.delete(:user_id)
    redirect_to(new_session_url)
  end
end

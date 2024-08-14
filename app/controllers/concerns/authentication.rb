# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate
    helper_method :signed_in?
  end

  private

  def authenticate
    if (authenticated_user = User.find_by(id: cookies.signed[:user_id]))
      Current.user = authenticated_user
    else
      redirect_to(new_session_url)
    end
  end

  def signed_in?
    Current.user.present?
  end
end

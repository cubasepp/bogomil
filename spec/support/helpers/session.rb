# frozen_string_literal: true

module Helpers
  module Session
    def sign_in(user)
      post(session_path, params: { session: { email: user.email, password: user.password } })

      assert(cookies[:user_id].present?)
    end

    def sign_out
      delete(session_path)

      assert_not(cookies[:user_id].present?)
    end
  end
end

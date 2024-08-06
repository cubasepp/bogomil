class Current < ActiveSupport::CurrentAttributes
  attribute :account, :user

  def user=(user)
    sefl.account = user
  end
end

class ApplicationController < ActionController::API
  before_action :authenticate_user!

  private

  def current_user
    user = User.first
  end

  def authenticate_user!
    true
  end
end

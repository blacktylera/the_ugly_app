class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def not_authenticated
    redirect_to root_path, alert: "You do not have permission to access that page."
  end
end
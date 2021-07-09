class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  def protect_from_forgery
  end
end

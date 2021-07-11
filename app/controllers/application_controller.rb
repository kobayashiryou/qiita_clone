class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  def protect_from_forgery
  end
end

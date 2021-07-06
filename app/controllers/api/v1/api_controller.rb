class Api::V1::ApiController < ApplicationController
  alias_method :current_user, :current_api_v1_user
  alias_method :authenticate_user!, :authenticate_api_v1_user!
  alias_method :user_sign_in?, :api_v1_user_sign_in?
end

class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController
  before_action :authenticate_api_v1_user!, only: [:destroy]

  private

    def resource_params
      params.permit(:nickname, :email, :password)
    end
end

class Api::V1::Auth::RegistrationsController < Api::V1::ApiController
  def create
    user = User.new
    render json: {
      data: user
    }
  end
end

require "rails_helper"

RSpec.describe "Registrarions", type: :request do
  describe "POST api/v1/auth" do
    subject { post(api_v1_user_registration_path, params: params) }

    let(:params) { attributes_for(:user) }

    it "新規登録される" do
      expect { subject }.to change { User.count }.by(1)
      res = response.headers
      expect(res.keys).to include "access-token", "token-type", "client", "expiry", "uid"
      expect(response).to have_http_status(:ok)
    end
  end
end

require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe "POST api/v1/auth/sign_in" do
    subject { post(api_v1_user_session_path, params: params) }

    let(:user) { create(:user) }
    let(:params) {
      {
        email: user.email,
        nickname: user.nickname,
        password: user.password,
      }
    }
    context "登録済みユーザーの必要情報が入力されている時" do
      it "ログインする" do
        subject
        res = response.headers
        expect(res.keys).to include "access-token", "token-type", "client", "expiry", "uid"
        expect(response).to have_http_status(:ok)
      end
    end

    context "emailが間違っている時" do
      let(:params) {
        {
          email: Faker::Internet.email,
        }
      }
      it "ログインできない" do
        subject
        res = JSON.parse(response.body)
        expect(res["success"]).to eq false
        expect(res["errors"]).to include "Invalid login credentials. Please try again."
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "nicknameが間違っている時" do
      let(:params) {
        {
          nickname: Faker::Internet.username,
        }
      }
      it "ログインできない" do
        subject
        res = JSON.parse(response.body)
        expect(res["success"]).to eq false
        expect(res["errors"]).to include "Invalid login credentials. Please try again."
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "passwordが間違っている時" do
      let(:params) {
        {
          password: Faker::Internet.password(min_length: 6),
        }
      }
      it "ログインできない" do
        subject
        res = JSON.parse(response.body)
        expect(res["success"]).to eq false
        expect(res["errors"]).to include "Invalid login credentials. Please try again."
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE api/v1/auth/sign_out" do
    subject { delete(destroy_api_v1_user_session_path, headers: headers) }

    let(:current_user) { create(:user) }
    let(:headers) { current_user.create_new_auth_token }
    context "ログインユーザーがログアウトした時" do
      it "ログアウトできる" do
        subject
        res = response.headers
        expect(res.keys).to not_include "access-token", "token-type", "client", "expiry", "uid"
        expect(response).to have_http_status(:ok)
      end
    end
  end
end

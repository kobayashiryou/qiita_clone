require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe "POST api/v1/auth/sign_in" do
    subject{ post(api_v1_user_session_path, params: params, headers: {'CONTENT_TYPE' => 'application/json'}) }

    let(:user){ create(:user) }
    let(:params){
      {
        email: user.email,
        nickname: user.nickname,
        password: user.password
      }.to_json
    }
    context "登録済みユーザーの必要情報が入力されている時" do
      it "ログインする" do
        subject
        res = response.headers
        expect(res.keys).to include "access-token", "token-type", "client", "expiry", "uid"
        expect(response).to have_http_status(200)
      end
    end

    context "emailが間違っている時" do
      let(:params){
        {
          email: Faker::Internet.email
        }.to_json
      }
      it "ログインできない" do
        subject
        res = JSON.parse(response.body)
        expect(res["success"]).to eq false
        expect(res["errors"]).to include "Invalid login credentials. Please try again."
        expect(response).to have_http_status(401)
      end
    end

    context "nicknameが間違っている時" do
      let(:params){
        {
          nickname: Faker::Internet.username
        }.to_json
      }
      it "ログインできない" do
        subject
        res = JSON.parse(response.body)
        expect(res["success"]).to eq false
        expect(res["errors"]).to include "Invalid login credentials. Please try again."
        expect(response).to have_http_status(401)
      end
    end

    context "passwordが間違っている時" do
      let(:params){
        {
          password: Faker::Internet.password(min_length: 6)
        }.to_json
      }
      it "ログインできない" do
        subject
        res = JSON.parse(response.body)
        expect(res["success"]).to eq false
        expect(res["errors"]).to include "Invalid login credentials. Please try again."
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "DELETE api/v1/auth/sign_out" do
    subject{ delete(destroy_api_v1_user_session_path, headers: headers) }
    before do
      allow_any_instance_of(Api::V1::ApiController).to receive(:current_user).and_return(current_user)
    end
    let(:current_user){ create(:user) }
    let(:headers){ current_user.create_new_auth_token }
    context "ログインユーザーがログアウトした時" do
      it "ログアウトできる" do
        subject
        res = response.headers
        expect(res.keys).to not_include "access-token", "token-type", "client", "expiry", "uid"
        expect(response).to have_http_status(200)
      end
    end
  end
end
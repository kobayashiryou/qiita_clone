require "rails_helper"

RSpec.describe User, type: :model do
  context "validation check" do
    subject { user.valid? }

    let(:user) { build(:user, nickname: nickname, password: password, email: email) }
    let(:nickname) { Faker::Internet.username }
    let(:password) { Faker::Internet.password(min_length: 6) }
    let(:email) { Faker::Internet.email }

    context "nicknameを指定している時" do
      it "ユーザーがエラーすることなく作られる" do
        expect(subject).to eq true
      end
    end

    context "nicknameを指定していない時" do
      let(:nickname) { nil }
      it "エラーする" do
        subject
        expect(user.errors.messages[:nickname]).to include "can't be blank"
      end
    end

    context "同じnicknameが存在している時" do
      let!(:user_same) { create(:user, nickname: "harry") }
      let(:nickname) { "harry" }
      it "エラーする" do
        subject
        expect(user.errors.messages[:nickname]).to include "has already been taken"
      end
    end

    context "emailを指定していない時" do
      let(:email) { nil }
      it "エラーする" do
        subject
        expect(user.errors.messages[:email]).to include "can't be blank"
      end
    end

    context "passwordを指定していない時" do
      let(:password) { nil }
      it "エラーする" do
        subject
        expect(user.errors.messages[:password]).to include "can't be blank"
      end
    end

    context "passwordが6文字未満の時" do
      let(:password) { "aaa" }
      it "エラーする" do
        subject
        expect(user.errors.messages[:password]).to include "is too short (minimum is 6 characters)"
      end
    end
  end
end

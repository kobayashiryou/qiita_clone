require "rails_helper"

RSpec.describe User, type: :model do
  context "validation check" do
    context "nicknameを指定している時" do
      it "ユーザーが作られる" do
        user = create(:user)
        expect(user).to be_valid
      end
    end

    context "nicknameを指定していない時" do
      it "エラーする" do
        user = build(:user, nickname: nil)
        user.valid?
        expect(user.errors.messages[:nickname]).to include "can't be blank"
      end
    end

    context "同じnicknameが存在している時" do
      it "エラーする" do
        create(:user, nickname: "harry")
        user = build(:user, nickname: "harry")
        user.valid?
        expect(user.errors.messages[:nickname]).to include "has already been taken"
      end
    end

    context "emailを指定していない時" do
      it "エラーする" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors.messages[:email]).to include "can't be blank"
      end
    end

    context "passwordを指定していない時" do
      it "エラーする" do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors.messages[:password]).to include "can't be blank"
      end
    end

    context "passwordが6文字未満の時" do
      it "エラーする" do
        user = build(:user, password: "aaa")
        user.valid?
        expect(user.errors.messages[:password]).to include "is too short (minimum is 6 characters)"
      end
    end
  end
end

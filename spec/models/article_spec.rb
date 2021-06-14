require 'rails_helper'

RSpec.describe Article, type: :model do
  context "title,bodyが指定されている時" do
    before do
      @user = create(:user)
    end
    it "記事が作成される" do
      article = build(:article, user_id: @user.id)
      expect(article).to be_valid
    end
  end

  context "title,bodyが指定されていない時" do
    before do
      @user = create(:user)
    end
    it "titleが指定されていない時にエラーする" do
      article = build(:article, user_id: @user.id, title: nil)
      article.valid?
      expect(article.errors.messages[:title]).to include "can't be blank"
    end

    it "bodyが指定されていない時にエラーする" do
      article = build(:article, user_id: @user.id, body: nil)
      article.valid?
      expect(article.errors.messages[:body]).to include "can't be blank"
    end
  end
end

require "rails_helper"

RSpec.describe Comment, type: :model do
  context "validation check" do
    context "contentが指定されている時とされていない時" do
      let!(:user){ create(:user) }
      let!(:article){ create(:article, user_id: user.id) }

      it "contentが指定されているとcommentが作成される" do
        comment = create(:comment, user_id: user.id, article_id: article.id)
        expect(comment).to be_valid
      end

      it "contentが指定されていない時にエラーする" do
        comment = build(:comment, user_id: user.id, article_id: article.id, content: nil)
        comment.valid?
        expect(comment.errors.messages[:content]).to include "can't be blank"
      end
    end
  end
end

require "rails_helper"

RSpec.describe Comment, type: :model do
  context "validation check" do
    let!(:user){ create(:user) }
    let!(:article){ create(:article, user: user) }
    let(:comment){ build(:comment, user: user, article: article, content: content) }
    let(:content){ Faker::Lorem.sentence }
    subject{ comment.valid? }
    context "contentが指定されている時" do
      it "エラーすることなくcommentが作成される" do
        expect(subject).to eq true
      end
    end
    context "contentが指定されていない時" do
      let(:content){ nil }
      it "エラーする" do
        subject
        expect(comment.errors.messages[:content]).to include "can't be blank"
      end
    end
  end
end

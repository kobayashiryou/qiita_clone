require "rails_helper"

RSpec.describe Article, type: :model do
  context "validation check" do
    let!(:user){ create(:user) }
    let(:article){ build( :article, user: user, title: title, body: body) }
    let(:title){ Faker::Lorem.sentence }
    let(:body){ Faker::Lorem.sentences }
    subject{ article.valid? }
    context "title,bodyが指定されている時" do
      it "記事がエラーすることなく作成される" do
        expect(subject).to eq true
      end
    end

    context "titleが指定されていない時" do
      let(:title){ nil }
      it "エラーする" do
        subject
        expect(article.errors.messages[:title]).to include "can't be blank"
      end
    end
    context "bodyが指定されていない時" do
      let(:body){ nil }
      it "エラーする" do
        subject
        expect(article.errors.messages[:body]).to include "can't be blank"
      end
    end
  end
end

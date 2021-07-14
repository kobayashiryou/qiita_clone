require "rails_helper"

RSpec.describe Article, type: :model do
  describe "validation check" do
    subject { article.valid? }

    let!(:user) { create(:user) }
    let(:article) { build(:article, user: user, title: title, body: body, status: status) }
    let(:title) { Faker::Lorem.sentence }
    let(:body) { Faker::Lorem.sentences }
    let(:status) { :published }

    context "title,body,statusが指定されている時" do
      it "記事がエラーすることなく作成される" do
        expect(subject).to eq true
      end
    end

    context "titleが指定されていない時" do
      let(:title) { nil }
      it "エラーする" do
        subject
        expect(article.errors.messages[:title]).to include "can't be blank"
      end
    end

    context "bodyが指定されていない時" do
      let(:body) { nil }
      it "エラーする" do
        subject
        expect(article.errors.messages[:body]).to include "can't be blank"
      end
    end

    context "statusが指定されていない時" do
      let(:status) { nil }
      it "エラーする" do
        subject
        expect(article.errors.messages[:status]).to include "can't be blank"
      end
    end
  end

  describe "下書き機能の確認" do
    let(:article) { create(:article, status: status) }
    let(:status) { :published }
    context "statusがpulishedの時" do
      it "公開記事だけ取得できる" do
        expect(article.status).to include "published"
      end
    end

    context "statusがdraftの時" do
      let(:status) { :draft }
      it "下書き記事だけ取得できる" do
        expect(article.status).to include "draft"
      end
    end
  end
end

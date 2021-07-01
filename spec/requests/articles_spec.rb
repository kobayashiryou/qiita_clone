require "rails_helper"

RSpec.describe "Articles", type: :request do
  describe "GET api/v1/articles" do
    subject { get(api_v1_articles_path) }

    before do
      create_list(:article, 3)
    end

    it "記事一覧が表示される" do
      subject
      res = JSON.parse(response.body)
      expect(res.length).to eq 3
      expect(res[0].keys).to eq ["id", "title", "body", "user_id"]
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET api/v1/articles/:id" do
    subject { get(api_v1_article_path(article_id)) }

    context "指定したidが存在する時" do
      let!(:article) { create(:article) }
      let(:article_id) { article.id }
      it "指定された記事が表示される" do
        subject
        res = JSON.parse(response.body)
        expect(res["title"]).to eq article.title
        expect(res["body"]).to eq article.body
        expect(res["user_id"]).to eq article.user_id
        expect(response).to have_http_status(:ok)
      end
    end

    context "指定したidが存在しない時" do
      let(:article_id) { 0 }
      it "エラーする" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "POST api/v1/articles" do
    subject { post(api_v1_articles_path, params: params) }

    let(:current_user) { create(:user) }
    let(:params) { { article: attributes_for(:article) } }

    before do
      allow_any_instance_of(Api::V1::ApiController).to receive(:current_user).and_return(current_user)
    end

    context "current_userが記事を作成した時" do
      it "記事は作成される" do
        expect { subject }.to change { current_user.articles.count }.by(1)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "PATCH api/v1/articles/:id" do
    subject { patch(api_v1_article_path(article_id), params: params) }

    before do
      allow_any_instance_of(Api::V1::ApiController).to receive(:current_user).and_return(current_user)
    end

    let!(:current_user) { create(:user) }
    let(:article) { create(:article, user: current_user) }
    let(:article_id) { article.id }
    let(:params) { { article: { title: Faker::Lorem.sentence, created_at: Time.current } } }

    context "current_userが指定した記事を編集した時" do
      it "記事は編集される" do
        expect { subject }.to change { Article.find(article_id).title }.from(article.title).to(params[:article][:title]) &
                              not_change { Article.find(article_id).body } &
                              not_change { Article.find(article_id).user_id } &
                              not_change { Article.find(article_id).created_at }
        expect(response).to have_http_status(:ok)
      end
    end

    context "current_userが他の記事を編集した時" do
      let(:article) { create(:article) }
      it "エラーする" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "DELETE api/v1/articles/:id" do
    subject { delete(api_v1_article_path(article_id)) }

    before do
      allow_any_instance_of(Api::V1::ApiController).to receive(:current_user).and_return(current_user)
    end

    let!(:current_user) { create(:user) }
    let!(:article) { create(:article, user: current_user) }
    let!(:article_id) { article.id }

    context "current_userが指定した記事を削除した時" do
      it "記事は削除される" do
        expect { subject }.to change { current_user.articles.count }.by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context "current_userが他の記事を削除しようとする時" do
      let(:article) { create(:article) }
      let(:article_id) { article.id }
      it "エラーする" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end

require "rails_helper"

RSpec.describe "Drafts", type: :request do
  describe "GET api/v1/articles/draft" do
    subject { get(api_v1_articles_drafts_path, headers: headers) }

    let!(:current_user) { create(:user) }
    let(:headers) { current_user.create_new_auth_token }
    before do
      create_list(:article, 3, status: :draft, user: current_user)
      create_list(:article, 3, status: :published, user: current_user)
    end

    context "statusがdraftの時" do
      it "下書き記事一覧が表示される" do
        subject
        res = JSON.parse(response.body)
        draft = res.select{|re| re["status"] == "draft" }
        expect(draft.length).to eq 3
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET api/v1/articles/draft/:id" do
    subject { get(api_v1_articles_draft_path(article_id), headers: headers) }

    let!(:current_user) { create(:user) }
    let(:headers) { current_user.create_new_auth_token }
    let(:article) { create(:article, status: :draft, user: current_user) }
    let(:article_id) { article.id }
    context "指定したidのstatusがdraftだった時" do
      it "指定したidの下書き記事が表示される" do
        subject
        res = JSON.parse(response.body)
        expect(res["title"]).to eq article.title
        expect(res["body"]).to eq article.body
        expect(res["status"]).to eq article.status
        expect(response).to have_http_status(:ok)
      end
    end
  end
end

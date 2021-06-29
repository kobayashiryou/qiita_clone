require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET api/v1/articles" do
    subject{ get(api_v1_articles_path) }
    before do
      create_list(:article,3)
    end
    it "記事一覧が表示される" do
      subject
      res = JSON.parse(response.body)
      expect(res.length).to eq 3
      expect(res[0].keys).to eq ["id","title","body","user_id"]
      expect(response).to have_http_status(200)
    end
  end

  describe "GET api/v1/articles/:id" do
    subject{ get(api_v1_article_path(article_id)) }
    context "指定したidが存在する時" do
      let!(:article){ create(:article) }
      let(:article_id){ article.id }
      it "指定された記事が表示される" do
        subject
        res = JSON.parse(response.body)
        expect(res["title"]).to eq article.title
        expect(res["body"]).to eq article.body
        expect(res["user_id"]).to eq article.user_id
        expect(response).to have_http_status(200)
      end
    end
    context "指定したidが存在しない時" do
      let(:article_id){ 0 }
      it "エラーする" do
        expect{ subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end

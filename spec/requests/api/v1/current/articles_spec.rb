require "rails_helper"

RSpec.describe "Mypage", type: :request do
  describe "GET api/v1/current/articles" do
    subject{ get(api_v1_current_articles_path, headers: headers) }

    let!(:current_user){ create(:user) }
    let!(:user){ create(:user) }
    let(:headers){ current_user.create_new_auth_token }
    before do
      create_list(:article, 3, user: current_user)
      create_list(:article, 2, user: current_user, status: :draft)
      create_list(:article, 3, user: user)
    end

    context "current_userがmypageに接続した時" do
      it "current_userの公開記事一覧が表示される" do
        subject
        res = JSON.parse(response.body)
        expect(res.length).to eq current_user.articles.published.length
        expect(res).to not_include current_user.articles.draft
        expect(res).to not_include user.articles
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
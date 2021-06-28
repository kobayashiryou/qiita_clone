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
end

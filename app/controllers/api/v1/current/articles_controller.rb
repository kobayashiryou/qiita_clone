class Api::V1::Current::ArticlesController < Api::V1::ApiController
  before_action :authenticate_user!

  def index
    articles = current_user.articles.published.order(created_at: :desc)
    render json: articles
  end
end

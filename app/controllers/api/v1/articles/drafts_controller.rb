class Api::V1::Articles::DraftsController < Api::V1::ApiController
  before_action :set_article, only: [:show]
  before_action :authenticate_user!, only: [:index, :show]

  def index
    articles = current_user.articles.draft
    render json: articles, each_serializer: ArticleSerializer
  end

  def show
    render json: @article
  end

  def set_article
    @article = current_user.articles.find(params[:id])
  end
end

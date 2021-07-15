class Api::V1::Articles::DraftsController < Api::V1::ApiController
  before_action :set_article, only: [:show]

  def index
    articles = Article.draft
    render json: articles, each_serializer: ArticleSerializer
  end

  def show
    render json: @article
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
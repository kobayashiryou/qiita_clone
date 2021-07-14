class Api::V1::ArticlesController < Api::V1::ApiController
  before_action :set_article, only: [:show]
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  # GET api/v1/articles
  # GET api/v1/articles.json
  def index
    articles = Article.published
    render json: articles, each_serializer: ArticleSerializer
  end

  # GET api/v1/articles/1
  # GET api/v1/articles/1.json
  def show
    render json: @article, serializer: ArticleSerializer
  end

  # POST api/v1/articles
  # POST api/v1/articles.json
  def create
    article = current_user.articles.create!(article_params)
    render json: article
  end

  # PATCH/PUT api/v1/articles/1
  # PATCH/PUT api/v1/articles/1.json
  def update
    article = current_user.articles.find(params[:id])
    article.update!(article_params)
    render json: article
  end

  # DELETE api/v1/articles/1
  # DELETE api/v1/articles/1.json
  def destroy
    article = current_user.articles.find(params[:id])
    article.destroy!
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end

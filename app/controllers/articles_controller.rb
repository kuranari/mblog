class ArticlesController < ApplicationController
  skip_before_action :authenticate, only: [:index, :show]
  def index
    articles = Article.preload(:user).all

    render json: articles
  end

  def show
    article = Article.preload(:user).find(params[:id])
    render json: article
  end

  def create
    article = current_user.articles.new(article_params)

    if article.save
      render json: article
    else
      render json: { message: article.errors.full_messages.join("\n") }, status: :unprocessable_entity
    end
  end

  def update
    article = Article.find(params[:id])
    if article.update(article_params)
      render json: article
    else
      render json: { message: article.errors.full_messages.join("\n") }, status: :unprocessable_entity
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy

    head :no_content
  end

  private

  def article_params
    params.permit(:title, :body)
  end
end

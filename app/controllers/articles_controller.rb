class ArticlesController < ApplicationController
  def index
    articles = Article.preload(:user, :favorite_users).all
    authorize articles

    render json: articles
  end

  def show
    article = Article.preload(:user, :favorite_users).find(params[:id])
    authorize article

    render json: article
  end

  def create
    article = current_user.articles.new(article_params)
    authorize article

    if article.save
      render json: article
    else
      render json: { message: article.errors.full_messages.join("\n") }, status: :unprocessable_entity
    end
  end

  def update
    article = Article.find(params[:id])
    authorize article

    if article.update(article_params)
      render json: article
    else
      render json: { message: article.errors.full_messages.join("\n") }, status: :unprocessable_entity
    end
  end

  def destroy
    article = Article.find(params[:id])
    authorize article

    article.destroy

    head :no_content
  end

  private

  def article_params
    params.permit(:title, :body)
  end
end

class FavoritesController < ApplicationController
  def create
    article = Article.find(params[:article_id])
    favorite = article.favorites
                      .where(user_id: current_user.id)
                      .first_or_initialize
    favorite.save

    head :no_content
  end

  def destroy
    article = Article.find(params[:article_id])
    favorite = article.favorites.where(user_id: current_user.id).first
    favorite.destroy if favorite

    head :no_content
  end
end

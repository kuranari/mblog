class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body
  has_many :user
  has_many :favorite_users
end

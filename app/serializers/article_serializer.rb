class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body
  has_many :user
end

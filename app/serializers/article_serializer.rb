class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :user_id, :updated_at
end

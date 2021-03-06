class ArticlesShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :teaser, :body, :category, :date
  def date
    object.created_at.strftime('%F')
  end
end

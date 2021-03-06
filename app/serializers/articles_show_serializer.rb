class ArticlesShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :teaser, :body, :category, :location, :date
  def date
    object.created_at.strftime('%F')
  end
end

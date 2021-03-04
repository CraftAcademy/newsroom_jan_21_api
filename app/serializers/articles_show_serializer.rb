class ArticlesShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :teaser, :body, :date
  def date
    object.created_at.strftime('%F')
  end
end

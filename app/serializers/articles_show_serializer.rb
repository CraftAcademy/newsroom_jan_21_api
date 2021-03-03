class ArticlesShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :teaser, :date, :body
  def date
    object.created_at.strftime('%F')
  end
end

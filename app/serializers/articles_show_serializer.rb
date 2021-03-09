class ArticlesShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :teaser, :body, :category, :location, :image, :date
  def date
    object.created_at.strftime('%F')
  end
  def image
    object.image_url
  end
end

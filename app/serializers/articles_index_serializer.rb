class ArticlesIndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :teaser, :article_type, :category, :image, :date
  def date
    object.created_at.strftime('%F')
  end
  def image
    return nil unless object.image.attached?
    object.image_url
  end
end

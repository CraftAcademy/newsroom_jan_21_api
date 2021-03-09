class ArticlesShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :teaser, :body, :category, :location, :image, :date
  belongs_to :author, class_name: 'Admin'

  def date
    object.created_at.strftime('%F')
  end

  def image
    return nil unless object.image.attached?

    object.image_url
  end

  def author
    {
      id: object.admin.id,
      name: object.admin.name
    }
  end
end

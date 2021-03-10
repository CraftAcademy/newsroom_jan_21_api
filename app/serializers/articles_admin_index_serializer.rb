class ArticlesAdminIndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :teaser, :body, :article_type, :category, :location, :image, :date
  belongs_to :author, class_name: 'Admin'

  def date
    object.updated_at.strftime('%F')
  end

  def author
    {
      id: object.admin.id,
      name: object.admin.name
    }
  end

  def image
    return nil unless object.image.attached?

    object.image_url
  end
end

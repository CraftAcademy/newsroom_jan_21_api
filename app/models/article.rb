class Article < ApplicationRecord
  enum article_type: [:experience, :story]
  validates_presence_of :article_type, :title, :body, :teaser, :location, :category
  belongs_to :admin, optional: true
  has_one_attached :image

  def image_url
    Rails.env.test? ? ActiveStorage::Blob.service.path_for(image.key) : image.url(expires_in: 1.hour, disposition: 'inline')
  end
end
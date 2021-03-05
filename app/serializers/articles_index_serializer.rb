class ArticlesIndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :teaser, :article_type, :date
  def date
    object.created_at.strftime('%F')
  end
end

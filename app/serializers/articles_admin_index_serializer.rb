class ArticlesAdminIndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :date
  def date
    object.updated_at.strftime('%F')
  end
  belongs_to :admin
end

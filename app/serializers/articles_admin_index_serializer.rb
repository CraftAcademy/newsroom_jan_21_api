class ArticlesAdminIndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :date
  belongs_to :author, class_name: "Admin"

  def date
    object.updated_at.strftime('%F')
  end
  def author
   {
     id: object.admin.id,
    name: object.admin.name
  }
  end
end

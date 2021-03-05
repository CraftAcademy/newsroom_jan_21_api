class AddLocationToArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :location, :string
  end
end

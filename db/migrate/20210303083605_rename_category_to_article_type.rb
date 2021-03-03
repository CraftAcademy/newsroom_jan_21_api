class RenameCategoryToArticleType < ActiveRecord::Migration[6.1]
  def change
    rename_column :articles, :category, :article_type
  end
end

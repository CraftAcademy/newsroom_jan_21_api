class AddsArticleReferenceAndAddsRoleToAdmin < ActiveRecord::Migration[6.1]
  def change
    add_reference :articles, :admin, null: true, foreign_key: true
    add_column :admins, :role, :integer
  end
end

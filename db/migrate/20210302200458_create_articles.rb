class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :teaser
      t.text :body
      t.integer :category

      t.timestamps
    end
  end
end

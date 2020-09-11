class CreateArticleBody < ActiveRecord::Migration[6.0]
  def change
    create_table :article_bodies do |t|
      t.text :body
      t.references :article, null: false, foreign_key: true
      t.timestamps
    end
  end
end

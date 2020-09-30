class CreateArticleBody < ActiveRecord::Migration[6.0]
  def change
    create_table :article_bodies do |t|
      t.text :body
      t.integer :version
      t.string :updater
      t.boolean :stable_version, default: false
      t.references :article, null: false, foreign_key: true
      t.timestamps
    end
  end
end

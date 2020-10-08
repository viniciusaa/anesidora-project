class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.integer :body_count, default: 0
      t.string :name
      t.boolean :private, default: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end

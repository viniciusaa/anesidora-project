class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.integer :contributors, array: true, default: []
      t.timestamps
    end
  end
end

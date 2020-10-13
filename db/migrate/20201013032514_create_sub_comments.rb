class CreateSubComments < ActiveRecord::Migration[6.0]
  def change
    create_table :sub_comments do |t|
      t.text :body
      t.references :article, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end

class CreateContributions < ActiveRecord::Migration[6.0]
  def change
    create_table :contributions do |t|
      t.references :user, null: false
      t.references :article, null: false

      t.timestamps
    end
  end
end

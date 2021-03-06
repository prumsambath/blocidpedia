class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :title
      t.string :body
      t.boolean :private, null: false, default: false
      t.references :user, index: true

      t.timestamps
    end
  end
end

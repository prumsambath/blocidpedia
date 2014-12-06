class CreateCollaboration < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.integer :wiki_id
      t.integer :user_id
    end

    add_index :collaborations, :wiki_id
    add_index :collaborations, :user_id
  end
end

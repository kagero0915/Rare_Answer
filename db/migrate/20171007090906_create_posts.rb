class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string  :photo, null: false
      t.integer :fovo, default: 0
      t.timestamps null: false
    end
  end
end

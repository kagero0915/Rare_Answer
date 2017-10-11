class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.integer :post_id, null: false
      t.integer :user_id, null: false
      t.boolean :good, default: 0
      t.timestamps null: false
    end
  end
end

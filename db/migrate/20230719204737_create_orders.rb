class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.datetime :last_update
      t.datetime :date_create
      t.decimal :discount
      t.integer :status_id
      t.integer :tax_id

      t.timestamps
    end
    add_foreign_key :orders, :users
    add_foreign_key :orders, :statuses
    add_foreign_key :orders, :taxes
  end
end

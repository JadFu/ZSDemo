class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :category_id
      t.string :information
      t.decimal :price
      t.string :image
      t.decimal :discount
      t.datetime :last_update
      t.datetime :date_create

      t.timestamps
    end
    add_foreign_key :items, :categories
  end
end

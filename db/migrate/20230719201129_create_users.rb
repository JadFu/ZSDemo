class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, default: ""
      t.string :role
      t.string :address
      t.string :password_digest, null: false, default: ""

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end

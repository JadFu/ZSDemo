class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, unique: true
      t.string :password
      t.string :role, default: 'user'
      t.string :address
      t.string :password_digest, null: false, default: ""

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end

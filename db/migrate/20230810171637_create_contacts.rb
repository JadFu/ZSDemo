class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :title
      t.text :social_links
      t.text :contact_details
      t.text :team_details

      t.timestamps
    end
  end
end

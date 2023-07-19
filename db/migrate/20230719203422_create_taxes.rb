class CreateTaxes < ActiveRecord::Migration[7.0]
  def change
    create_table :taxes do |t|
      t.string :tax_region
      t.decimal :PST
      t.decimal :GST

      t.timestamps
    end
  end
end

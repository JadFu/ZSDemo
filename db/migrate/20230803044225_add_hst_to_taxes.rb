class AddHstToTaxes < ActiveRecord::Migration[7.0]
  def change
    add_column :taxes, :HST, :decimal
  end
end

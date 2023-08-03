class RemoveTaxIdFromOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :tax_id
  end
end

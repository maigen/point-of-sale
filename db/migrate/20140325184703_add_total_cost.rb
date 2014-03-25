class AddTotalCost < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.column :product_id, :integer
      t.column :receipt_id, :integer
      t.column :quantity, :integer
      t.column :total_cost, :decimal

      t.timestamps
    end
    add_column :receipts, :grand_total, :decimal
    drop_table :products_receipts
  end
end

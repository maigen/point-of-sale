class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.column :customer_id, :integer
      t.column :cashier_id, :integer

      t.timestamps
    end

    create_table :customers do |t|
      t.column :name, :string

      t.timestamps
    end

    create_table :products_receipts do |t|
      t.column :product_id, :integer
      t.column :receipt_id, :integer
      t.column :quantity, :integer

      t.timestamps
    end

    drop_table :purchases
  end
end

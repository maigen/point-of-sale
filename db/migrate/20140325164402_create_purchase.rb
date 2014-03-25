class CreatePurchase < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.column :product_id, :integer
      t.column :cashier_id, :integer

      t.timestamps
    end
    create_table :cashiers do |t|
      t.column :name, :string

      t.timestamps
    end
  end
end

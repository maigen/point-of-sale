class CreateProduct < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.column :name, :string
      t.column :cost, :decimal

      t.timestamps
    end
  end
end

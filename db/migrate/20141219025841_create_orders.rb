class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :numeroquartos
      t.integer :numeropessoas
      t.string :compradorname
      t.string :creditonumber
      t.string :creditocod
      t.date :creditovalidade
      t.decimal :valor, precision: 10, scale: 2
      t.integer :parcelas

      t.timestamps
    end
  end
end

class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :numeroquartos
      t.integer :numeropessoas
      t.string :compradorname
      t.string :creditonumber
      t.string :creditocod
      t.date :creditovalidade

      t.timestamps
    end
  end
end

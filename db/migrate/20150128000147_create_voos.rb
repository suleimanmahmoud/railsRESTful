class CreateVoos < ActiveRecord::Migration
  def change
    create_table :voos do |t|
      t.string :name
      t.integer :tipo
      t.string :origem
      t.string :destino
      t.date :dataida
      t.date :datavolta
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end

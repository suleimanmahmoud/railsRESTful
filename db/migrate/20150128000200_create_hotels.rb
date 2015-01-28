class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.integer :numeroquartos
      t.integer :numeropessoas
      t.string :destino
      t.date :dataentrada
      t.date :datasaida
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end

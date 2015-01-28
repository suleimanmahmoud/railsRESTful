json.array!(@hotels) do |hotel|
  json.extract! hotel, :id, :name, :numeroquartos, :numeropessoas, :destino, :dataentrada, :datasaida, :price
  json.url hotel_url(hotel, format: :json)
end

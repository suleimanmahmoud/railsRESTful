json.array!(@pacotes) do |pacote|
  json.extract! pacote, :id, :name, :description, :origem, :destino, :dataida, :datavolta, :price
  json.url pacote_url(pacote, format: :json)
end

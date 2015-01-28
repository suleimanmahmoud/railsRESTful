json.array!(@voos) do |voo|
  json.extract! voo, :id, :name, :tipo, :origem, :destino, :dataida, :datavolta, :price
  json.url voo_url(voo, format: :json)
end

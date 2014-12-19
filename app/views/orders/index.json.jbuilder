json.array!(@orders) do |order|
  json.extract! order, :id, :numeroquartos, :numeropessoas, :compradorname, :creditonumber, :creditocod, :creditovalidade, :Pacote_id
  json.url order_url(order, format: :json)
end

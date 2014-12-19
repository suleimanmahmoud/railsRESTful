json.array!(@orders) do |order|
  json.extract! order, :id, :numeroquartos, :numeropessoas, :compradorname, :creditonumber, :creditocod, :creditovalidade
  json.url order_url(order, format: :json)
end

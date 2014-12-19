json.array!(@orders) do |order|
  json.extract! order, :id, :numeroquartos, :numeropessoas, :compradorname, :creditonumber, :creditocod, :creditovalidade, :valor, :parcelas
  json.url order_url(order, format: :json)
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Pacote.create([{ name: 'Chicago 2 noites' ,  description: '2 noites em Chicago saindo de Curitiba',
	origem: 'Curitiba', destino: 'Chicago', dataida: '12/12/2014', datavolta: '14/12/2014',price: '3300,00'}])
Pacote.create([{ name: 'NYC 7 noites' ,  description: '2 noites em Chicago saindo de Curitiba',
	origem: 'Curitiba', destino: 'New York', dataida: '12/01/2015', datavolta: '19/01/2015',price: '6300,00'}])
Pacote.create([{ name: 'Orlando 7 noites' ,  description: '2 noites em Chicago saindo de Curitiba',
	origem: 'Curitiba', destino: 'Orlando', dataida: '12/02/2015', datavolta: '19/02/2015',price: '4300,00'}])
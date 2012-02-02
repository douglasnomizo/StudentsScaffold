class ClientesController < ApplicationController
	
	def find_all
	p "BEM VINDO AO MEU SISTEMA FODAO"
	p "eu vou imprimir o valor de params[0]"
		p params[0]
		p params[0].nome
		
		cliente = Cliente.new
		cliente.nome = params[0].nome
		
		cliente.id = 4
		cliente.save
		
		@clientes = Cliente.all
		
		respond_to do |format|
			format.amf { render :amf => @clientes }
		end
	end

end

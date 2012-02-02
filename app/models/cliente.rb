# coding: utf-8

class Cliente < ActiveRecord::Base
set_table_name "cliente"
set_sequence_name "cliente_sec" 	
	validates_presence_of :nome, :message => " - deve ser preenchido" # Valida a presença de um nome para o cliente
	validates_uniqueness_of :nome, :message => " - nome já cadastrado" # Valida a redundância de clientes com o mesmo nome
#	validates_numericality_of :idade,	# Valida a idade do cliente
#		:greater_than => 0,	# Deve ser maior ou igual a 0 (anos)
#		:less_than => 100, # Deve ser menor ou iguaol a 100 (anos)
#		:message => " - deve ser um número entre 0 e 100"
end

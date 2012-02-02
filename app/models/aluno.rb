# coding: utf-8

class Aluno < ActiveRecord::Base
  set_table_name "aluno"
  set_sequence_name "id"
  validates_presence_of :nome, :message => " deve ser preenchido"
  validates_uniqueness_of :nome, :message => " deve ser único"
  validates_presence_of :cpf, :message => " deve ser preenchido"
  validates_uniqueness_of :cpf, :message => " já cadastrado"
end

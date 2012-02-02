class AlunosController < ApplicationController

  def find_all
    @alunos = Aluno.all
    respond_to do |format|
      format.amf { render :amf => @alunos }
    end
  end

  def new_aluno
    @novo_aluno = Aluno.new
    @novo_aluno.nome = params[0].nome
    @novo_aluno.cpf = params[0].cpf
    @novo_aluno.data_nascimento = params[0].data_nascimento

    if @novo_aluno.save
      respond_to do |format|
        format.amf { render :amf => true }
      end
    else
      render :amf => FaultObject.new(@novo_aluno.errors.full_messages.join("\n"))
    end
  end

  def remover_aluno
    respond_to do |format|
      if params[0].destroy
        format.amf { render :amf => true }
      else
        render :amf => FaultObject.new(params[0].errors.full_messages.join("\n"))
      end
    end
  end
end
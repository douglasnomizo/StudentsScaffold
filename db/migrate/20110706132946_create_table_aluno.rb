class CreateTableAluno < ActiveRecord::Migration

  def self.up
    create_table :aluno do |t|
      t.string :nome
      t.string :cpf
      t.date :data_nascimento
      t.timestamps
    end
  end

  def self.down
    drop_table :aluno
  end

end

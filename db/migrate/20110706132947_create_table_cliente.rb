class CreateTableCliente < ActiveRecord::Migration

  def self.up
    create_table :cliente do |t|
      t.string :nome      
      t.timestamps
    end
  end

  def self.down
    drop_table :aluno
  end

end

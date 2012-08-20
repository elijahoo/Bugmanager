class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :token
      t.string :use_ssl
      t.string :connection

      t.timestamps
    end
  end
end

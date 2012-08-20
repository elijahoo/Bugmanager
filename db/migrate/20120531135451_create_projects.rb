class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :stories

      t.timestamps
    end
  end
end

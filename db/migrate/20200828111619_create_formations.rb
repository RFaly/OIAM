class CreateFormations < ActiveRecord::Migration[5.2]
  def change
    create_table :formations do |t|
      t.string :name
      t.text :description
      t.float :prix

      t.timestamps
    end
  end
end

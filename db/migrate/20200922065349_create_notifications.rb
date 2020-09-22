class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :object
      t.text :message
      t.string :link
      t.integer :genre
      t.boolean :view
      t.belongs_to :client, index:true
      t.belongs_to :cadre, index:true

      t.timestamps
    end
  end
end

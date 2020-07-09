class AddColumnToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :first_name, :string
    add_column :clients, :last_name, :string
    add_column :clients, :fonction, :string
    add_column :clients, :mail, :string
    add_column :clients, :telephone, :string
    add_column :clients, :image, :string
  end
end

class AddColumnToAdmin < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :first_name, :string
    add_column :admins, :last_name, :string
    add_column :admins, :metier, :string
    add_column :admins, :image, :string
  end
end

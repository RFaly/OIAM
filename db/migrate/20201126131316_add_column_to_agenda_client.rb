class AddColumnToAgendaClient < ActiveRecord::Migration[5.2]
  def change
    add_column :agenda_clients, :reponded, :boolean, default: :false
  end
end

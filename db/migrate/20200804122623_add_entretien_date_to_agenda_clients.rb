class AddEntretienDateToAgendaClients < ActiveRecord::Migration[5.2]
  def change
    add_column :agenda_clients, :entretien_date, :datetime
  end
end

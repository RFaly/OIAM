class AddAcceptedAtAgendaAdmins < ActiveRecord::Migration[5.2]
  def change
  	add_column :agenda_admins, :accepted, :boolean
  end
end

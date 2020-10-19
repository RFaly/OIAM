class AddColumnToAgendaAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :agenda_admins, :notifed, :boolean, default: :false
  end
end

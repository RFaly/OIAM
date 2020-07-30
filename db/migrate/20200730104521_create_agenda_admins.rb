class CreateAgendaAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :agenda_admins do |t|
      t.datetime :entretien_date
      t.belongs_to :cadre_info
      t.belongs_to :admin, index:true

      t.timestamps
    end
  end
end

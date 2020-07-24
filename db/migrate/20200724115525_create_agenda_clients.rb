class CreateAgendaClients < ActiveRecord::Migration[5.2]
  def change
    create_table :agenda_clients do |t|
      t.string :entretien_date
      t.string :entretien_time
      t.string :adresse
      t.string :recruteur
      t.string :alternative
      t.boolean :is_accepted
      t.belongs_to :offre_for_candidate, index:true
      
      t.timestamps
    end
  end
end

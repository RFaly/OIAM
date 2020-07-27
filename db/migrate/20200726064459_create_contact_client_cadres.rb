class CreateContactClientCadres < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_client_cadres do |t|
    	t.belongs_to :client, index:true
			t.belongs_to :cadre, index:true

      t.timestamps
    end
  end
end

class CreateMessageClientCadres < ActiveRecord::Migration[5.2]
  def change
    create_table :message_client_cadres do |t|
      t.text :content
			t.boolean :client_see, default: :false
			t.boolean :cadre_see, default: :false
			t.belongs_to :client, index:true
			t.belongs_to :cadre, index:true
      t.belongs_to :contact_client_cadre, index:true
      
      t.timestamps
    end
  end
end

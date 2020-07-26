class CreateMessageAdminClients < ActiveRecord::Migration[5.2]
  def change
    create_table :message_admin_clients do |t|
			t.text :content
			t.boolean :client_see, default: :false
			t.boolean :admin_see, default: :false
			t.belongs_to :client, index:true
			t.belongs_to :admin, index:true
			t.belongs_to :contact_admin_client, index:true

      t.timestamps
    end
  end
end

class CreateContactAdminClients < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_admin_clients do |t|
    	t.belongs_to :admin, index:true
			t.belongs_to :client, index:true
			
      t.timestamps
    end
  end
end

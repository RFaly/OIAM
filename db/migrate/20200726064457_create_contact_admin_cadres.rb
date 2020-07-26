class CreateContactAdminCadres < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_admin_cadres do |t|
    	t.belongs_to :admin, index:true
			t.belongs_to :cadre, index:true
			
      t.timestamps
    end
  end
end

class CreateMessageAdminCadres < ActiveRecord::Migration[5.2]
  def change
    create_table :message_admin_cadres do |t|
      t.text :content
			t.boolean :cadre_see, default: :false
			t.boolean :admin_see, default: :false
			t.belongs_to :admin, index:true
			t.belongs_to :cadre, index:true

      t.timestamps
    end
  end
end

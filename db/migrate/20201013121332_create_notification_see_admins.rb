class CreateNotificationSeeAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :notification_see_admins do |t|
      t.belongs_to :admin, index:true
			t.belongs_to :notification_admin, index:true

      t.timestamps
    end
  end
end

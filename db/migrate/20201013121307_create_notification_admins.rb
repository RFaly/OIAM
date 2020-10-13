class CreateNotificationAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :notification_admins do |t|
      t.string :object
      t.text :message
      t.string :link
      t.integer :genre
      t.integer :medel_id
      t.string :confirm_token

      t.timestamps
    end
  end
end

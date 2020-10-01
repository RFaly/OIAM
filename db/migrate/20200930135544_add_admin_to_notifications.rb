class AddAdminToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_reference :notifications, :admin, foreign_key: true
  end
end

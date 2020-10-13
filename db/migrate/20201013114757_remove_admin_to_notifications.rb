class RemoveAdminToNotifications < ActiveRecord::Migration[5.2]
  def change
  	remove_reference :notifications, :admin, foreign_key: true
  end
end

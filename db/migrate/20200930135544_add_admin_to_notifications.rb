class AddAdminToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_reference :notifications, :admin, foreign_key: true
  end
end



=begin
class RemoveClientFromUser < ActiveRecord::Migration
  def change
    remove_reference :users, :client, index: true, foreign_key: true
  end
end
=end


class AddOnlineTimeAtClients < ActiveRecord::Migration[5.2]
  def change
  	add_column :clients, :online_time, :datetime
  end
end

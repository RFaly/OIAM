class ClientTimeTryingToPromiseToHires < ActiveRecord::Migration[5.2]
  def change
 		add_column :promise_to_hires, :client_time_trying, :boolean
 		add_column :promise_to_hires, :cadre_time_trying, :boolean, default:false
 		add_column :promise_to_hires, :prime_received, :boolean, default:false
 		add_column :promise_to_hires, :ask_salar, :boolean, default:false
 		add_column :promise_to_hires, :confirm_token, :string
 		add_column :promise_to_hires, :rupture_time_trying, :string
  end
end

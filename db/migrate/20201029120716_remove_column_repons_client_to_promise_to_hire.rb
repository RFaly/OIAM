class RemoveColumnReponsClientToPromiseToHire < ActiveRecord::Migration[5.2]
  def change
  	remove_column :promise_to_hires, :repons_client, :boolean
  end
end

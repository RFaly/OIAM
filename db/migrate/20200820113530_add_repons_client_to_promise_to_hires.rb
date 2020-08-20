class AddReponsClientToPromiseToHires < ActiveRecord::Migration[5.2]
  def change
  	add_column :promise_to_hires, :payed, :boolean, default:false
    add_column :promise_to_hires, :repons_client, :boolean
    add_column :promise_to_hires, :repons_cadre, :boolean
    add_column :promise_to_hires, :cin_pass_port, :string
    add_column :promise_to_hires, :security_certificate, :string
    add_column :promise_to_hires, :rib, :string
  end
end

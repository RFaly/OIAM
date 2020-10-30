class AddColumnToPromiseToHire < ActiveRecord::Migration[5.2]
  def change
    add_column :promise_to_hires, :ov_prime, :string
  end
end

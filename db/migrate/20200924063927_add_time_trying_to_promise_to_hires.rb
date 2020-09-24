class AddTimeTryingToPromiseToHires < ActiveRecord::Migration[5.2]
  def change
    add_column :promise_to_hires, :time_trying, :string
  end
end

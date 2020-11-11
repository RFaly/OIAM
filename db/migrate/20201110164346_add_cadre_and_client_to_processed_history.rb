class AddCadreAndClientToProcessedHistory < ActiveRecord::Migration[5.2]
  def change
		add_reference :processed_histories, :client
		add_reference :processed_histories, :cadre_info
		add_column :processed_histories, :see, :boolean, default: :false
  end
end

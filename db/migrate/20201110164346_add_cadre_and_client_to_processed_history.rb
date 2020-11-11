class AddCadreAndClientToProcessedHistory < ActiveRecord::Migration[5.2]
  def change
		add_reference :processed_histories, :client
		add_reference :processed_histories, :cadre_info
  end
end

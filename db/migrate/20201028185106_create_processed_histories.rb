class CreateProcessedHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :processed_histories do |t|
      t.text :image
      t.text :message
      t.string :link
      t.boolean :is_client
      t.boolean :is_see, default: :false
      t.integer :genre
      t.string :confirm_token

      t.timestamps
    end
  end
end

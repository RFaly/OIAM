class AddConfirmableToDeviseClient < ActiveRecord::Migration[5.2]
  def self.up
    add_column :clients, :confirmation_token, :string
    add_column :clients, :confirmed_at,       :datetime
    add_column :clients, :confirmation_sent_at , :datetime
    add_column :clients, :unconfirmed_email, :string

    add_index  :clients, :confirmation_token, :unique => true
  end

  def self.down
    remove_index  :clients, :confirmation_token

    remove_column :clients, :unconfirmed_email
    remove_column :clients, :confirmation_sent_at
    remove_column :clients, :confirmed_at
    remove_column :clients, :confirmation_token
  end
end

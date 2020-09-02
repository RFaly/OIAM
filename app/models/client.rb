class Client < ApplicationRecord
  after_create :edit_online_time

	has_one :entreprise
	has_many :offre_jobs

  has_many :factures

	has_many :contact_client_cadres
  has_many :cadres, through: :contact_client_cadres

	has_many :contact_admin_clients
  has_many :admins, through: :contact_admin_clients

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def is_online?
    return self.online_time > 5.minutes.ago
  end
  #time_ago_in_words(self.online_time)

  def edit_online_time
    self.update(online_time: Time.current)
  end
end

class Client < ApplicationRecord
	has_one :entreprise
	has_many :offre_jobs

	has_many :message_client_cadres
  has_many :cadres, through: :message_client_cadres

	has_many :message_admin_clients
  has_many :admins, through: :message_admin_clients

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

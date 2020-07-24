class Admin < ApplicationRecord
	has_many :message_admin_clients
  has_many :clients, through: :message_admin_clients

  has_many :message_admin_cadres
  has_many :cadres, through: :message_admin_cadres

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

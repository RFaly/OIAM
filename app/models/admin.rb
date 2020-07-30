class Admin < ApplicationRecord
	has_many :contact_admin_clients
  has_many :clients, through: :contact_admin_clients

  has_many :contact_admin_cadres
  has_many :cadres, through: :contact_admin_cadres

  has_many :agenda_admins
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

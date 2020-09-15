class Admin < ApplicationRecord
	has_many :contact_admin_clients
  has_many :clients, through: :contact_admin_clients

  has_many :contact_admin_cadres
  has_many :cadres, through: :contact_admin_cadres

  has_many :agenda_admins

  has_many :cadre_infos

  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

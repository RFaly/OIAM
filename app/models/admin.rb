class Admin < ApplicationRecord
	has_many :contact_admin_clients
  has_many :clients, through: :contact_admin_clients

  has_many :contact_admin_cadres
  has_many :cadres, through: :contact_admin_cadres

  has_many :agenda_admins

  has_many :cadre_infos

  has_many :notification_see_admins
  has_many :notification_admins, through: :notification_see_admins


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def numberOfNotification
    self.notifications.where(view:false).count
  end

  def number_message_not_see
    if  @contactCadre = self.contact_admin_cadres
        number = 0
        @contactCadre.each do |contact|
          if contact.mp_admin_not_see > 0
            number += 1
          end
        end
      return number
    elsif @contactClient = self.contact_admin_clients
          number = 0
          @contactClient.each do |contact|
          if contact.mp_admin_not_see > 0
            number += 1
          end
        end
      return number
    end
  end

end

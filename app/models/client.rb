class Client < ApplicationRecord
  after_create :edit_online_time

  has_many :processed_histories

	has_one :entreprise
	has_many :offre_jobs

  has_many :factures

	has_many :contact_client_cadres
  has_many :cadres, through: :contact_client_cadres

	has_many :contact_admin_clients
  has_many :admins, through: :contact_admin_clients

  has_many :notifications

  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  
  def is_online?
    return self.online_time > 5.minutes.ago
  end
  #time_ago_in_words(self.online_time)

  def edit_online_time
    self.update(online_time: Time.current)
  end


  def numberOfNotification
    @notifications = self.notifications.where(view:false)
    all = @notifications.count
    # 1: suivi recrutement [medel_id: cadre ] (suivi recrutement +1)
    suivi = @notifications.where(genre:1).count
    # 2: pour la facture ne pas afficher (facture +1)
    facture = @notifications.where(genre:2).count
    # 3: postule candidat [medel_id: cadre] (tsy apina aiza aiza)
    # postule = @notifications.where(genre:3).count
    notice = {}
    notice[:all] = all
    notice[:suivi] = suivi
    notice[:facture] = facture
    return notice
  end

  def number_message_not_see
    @contactListes = self.contact_client_cadres
    number = 0
    @contactListes.each do |contact|
      if contact.mp_client_not_see > 0
        number += 1
      end
    end
    return number
  end

end

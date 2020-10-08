class Cadre < ApplicationRecord
  after_create :edit_online_time

	has_one :cadre_info

  has_many :facture_formations
  has_many :formations, through: :facture_formations

	has_many :promise_to_hires
  has_many :offre_jobs, through: :promise_to_hires

  has_many :offre_for_candidates
  has_many :offre_jobs, through: :offre_for_candidates

  has_many :favorite_jobs
  has_many :offre_jobs, through: :favorite_jobs

  has_many :contact_client_cadres
  has_many :clients, through: :contact_client_cadres
  
  has_many :contact_admin_cadres
  has_many :admins, through: :contact_admin_cadres

  has_many :notifications

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

  def numberOfNotification
    @notifications = self.notifications.where(view:false)
    all = @notifications.count
    # 1: [medel_id: offre_job ] add to (received job +1)
    received = @notifications.where(genre:1).count
    # 2: [medel_id: offre_job] add to (suivi recrutement +1)
    suivi = @notifications.where(genre:2).count
    #
    notice = {}
    notice[:all] = all
    notice[:received] = received
    notice[:suivi] = suivi
    #
    return notice
  end

  def number_message_not_see
    @contactListes = self.contact_client_cadres
    number = 0
    @contactListes.each do |contact|
      if contact.mp_cadre_not_see > 0
        number += 1
      end
    end
    return number
  end

end

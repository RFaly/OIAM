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
end

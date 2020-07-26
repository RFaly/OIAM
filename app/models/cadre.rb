class Cadre < ApplicationRecord
  after_create :edit_online_time

	has_one :cadre_info

	has_many :promise_to_hires
  has_many :offre_jobs, through: :promise_to_hires

  has_many :offre_for_candidates
  has_many :offre_jobs, through: :offre_for_candidates

  has_many :favotire_jobs
  has_many :offre_jobs, through: :favotire_jobs

  has_many :message_client_cadres
  has_many :clients, through: :message_client_cadres
  
  has_many :message_admin_cadres
  has_many :admins, through: :message_admin_cadres

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

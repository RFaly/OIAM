class Cadre < ApplicationRecord
	has_one :cadre_info

	has_many :promise_to_hires
  has_many :offre_jobs, through: :promise_to_hires

  has_many :offre_for_candidates
  has_many :offre_jobs, through: :offre_for_candidates

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

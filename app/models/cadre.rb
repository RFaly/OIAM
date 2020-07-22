class Cadre < ApplicationRecord
	has_one :cadre_info
	has_many :promise_to_hires
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

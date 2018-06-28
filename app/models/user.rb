class User < ActiveRecord::Base

	validates :emailadd, presence: true, uniqueness: true
	validates :password, presence: true
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :job_title, presence: true
	validates :phone, presence: true

end
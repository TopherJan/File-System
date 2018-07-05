class User < ApplicationRecord
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
	  user.last_name = auth.info.last_name
      user.emailadd = auth.info.email
   	  user.save!
    end
  end
  
  validates :emailadd,
   uniqueness: true, presence: true,
   format: {
     message: 'domain must be @up.edu.ph', with: /\A[\w+-.]+@up.edu.ph\z/i}
end

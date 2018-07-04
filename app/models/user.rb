class User < ApplicationRecord


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.fullname = auth.info.name
      user.emailadd = auth.info.email
  	  User.create!(:provider => user.provider, :uid => user.uid, :emailadd => user.emailadd, :first_name => user.fullname, :last_name => nil, :password => "12345", :job_title => nil, :phone => nil)
    end
  end
  validates :emailadd, uniqueness: true
end

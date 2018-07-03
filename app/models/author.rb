class Author < ActiveRecord::Base
  has_many :documents, dependent: :destroy
  
  validates :name, presence: true
  validates :contact, presence: true
  validates :agency, presence: true
  validates :address, presence: true
end

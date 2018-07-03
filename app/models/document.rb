class Document < ActiveRecord::Base
  has_one :author
  has_many :event
  
  validates :name, presence: true
  validates :doc_type, presence: true
  validates :description, presence: true
  validates :location, presence: true
end

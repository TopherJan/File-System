class Document < ActiveRecord::Base
  has_one :author
  has_many :event
end

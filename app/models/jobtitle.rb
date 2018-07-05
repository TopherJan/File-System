class Jobtitle < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end

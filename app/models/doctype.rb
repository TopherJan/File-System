class Doctype < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end

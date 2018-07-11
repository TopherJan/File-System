class Forward < ApplicationRecord
  validates :user_id, presence: true
  validates :doc_id, presence: true
end

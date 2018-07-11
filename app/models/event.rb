class Event < ActiveRecord::Base
  belongs_to :document, optional: true
  validates :event_date, presence: true
  validates :event_type, presence: true
  validates :doc_id, presence: true
end

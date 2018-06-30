class Event < ActiveRecord::Base
  belongs_to :document, optional: true
end

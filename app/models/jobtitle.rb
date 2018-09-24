class Jobtitle < ApplicationRecord
  after_initialize :default_values

  private
    def default_values
      self.viewDocument ||= false
	  self.addDocument ||= false
	  self.editDocument ||= false
	  self.deleteDocument ||= false
	  self.forwardDocument ||= false
	  self.addEvent ||= false
	  self.uploadFile ||= false
	  self.deleteFile ||= false
	  self.userRequest ||= false
	  self.jobtitleSettings ||= false
	  self.doctypeSettings ||= false
	  self.userSettings ||= false
    end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Attachment.destroy_all
Author.destroy_all
Doctype.destroy_all
Document.destroy_all
Event.destroy_all
Forward.destroy_all
Jobtitle.destroy_all
Request.destroy_all
User.destroy_all

Doctype.create!(name: 'Letter')
Doctype.create!(name: 'Memo')
Doctype.create!(name: 'Endorsement')
Doctype.create!(name: 'Request')
Doctype.create!(name: 'Recommendation')
Doctype.create!(name: 'Travel Order')
Doctype.create!(name: 'Voucher')

Jobtitle.create!(name: 'Admin', viewDocument: true, addDocument: true, editDocument: true, deleteDocument: true, forwardDocument: true, addEvent: true, uploadFile: true, deleteFile: true, userRequest: true, jobtitleSettings: true, doctypeSettings: true , userSettings: true)
User.create!(first_name: 'Admin', last_name: 'System', emailadd: 'admin@up.edu.ph', password: 'admin', password_confirmation: 'admin', job_title: 'Admin', phone: '09278781163')
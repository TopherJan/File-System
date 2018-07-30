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

Jobtitle.create!(name: 'Dean')
Jobtitle.create!(name: 'Secretary')
Jobtitle.create!(name: 'Faculty')
Jobtitle.create!(name: 'DNSM Secretary')
Jobtitle.create!(name: 'DM Secretary')
Jobtitle.create!(name: 'DSS Secretary')
Jobtitle.create!(name: 'DH Secretary')

Doctype.create!(name: 'Letter')
Doctype.create!(name: 'Memo')
Doctype.create!(name: 'Endorsement')
Doctype.create!(name: 'Request')
Doctype.create!(name: 'Recommendation')
Doctype.create!(name: 'Travel Order')
Doctype.create!(name: 'Voucher')

User.create!(first_name: 'Admin', last_name: 'System', emailadd: 'admin@up.edu.ph', password: 'admin', job_title: 'Admin', phone: '09278781163')
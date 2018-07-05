# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Jobtitle.destroy_all
Doctype.destroy_all
User.destroy_all
Event.destroy_all
Attachment.destroy_all
Author.destroy_all
Document.destroy_all

Jobtitle.create!(name: 'Dean')
Jobtitle.create!(name: 'Associate Dean')

Doctype.create!(name: 'Letter')
Doctype.create!(name: 'Memo')
Doctype.create!(name: 'Endorsement')
Doctype.create!(name: 'Request')
Doctype.create!(name: 'Recommendation')
Doctype.create!(name: 'Travel Order')
Doctype.create!(name: 'Voucher')

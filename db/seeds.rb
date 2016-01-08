# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
 User.create!(name:"uzaif",email:"uzaif@gmail.com",password:"123456",password_confirmation:"123456",admin:true,activated:true,activated_at: Time.zone.now)

 49.times do |n|
   name=Faker::Name.name
   randomstr =([*'0a'..'9z']).shuffle.take(2).join
   email     = "corporats_#{randomstr}.#{n}@gmail.com"
   password  ="test1234"
   User.create!(name: name,email: email,password: password,password_confirmation:password,activated:true,activated_at: Time.zone.now)
 end
  users = User.order(:created_at).take(6)
  50.times do |n|
    content=Faker::Lorem.sentence(5)
    users.each {|user| user.microposts.create!(content:content)}
  end

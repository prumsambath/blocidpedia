require 'faker'

# create users
5.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'helloworld'
  )
  user.skip_confirmation!
  user.save
end
users = User.all
# set first and last users to premium account
first_user = users.first
first_user.role = "premium"
first_user.save

last_user = users.last
last_user.role = "premium"
last_user.save

# create wikis
100.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    user: users.sample
  )
end

puts "Seeding finished"
puts "#{User.count} users created."
puts "#{Wiki.count} wikis created."
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
City.destroy_all
Gossip.destroy_all
Tag.destroy_all
JoinGossipTag.destroy_all
PrivateMessage.destroy_all
JoinPmRecipient.destroy_all
Comment.destroy_all

10.times do
	City.create(name:Faker::Address.city, zip_code:Faker::Address.zip_code)
end

10.times do
	User.create(last_name:Faker::Name.last_name, first_name:Faker::Name.first_name, email: Faker::Internet.email, age:rand(12..100), description:Faker::Lorem.paragraph, city_id:City.all.sample.id)
end

20.times do
	Gossip.create(title:Faker::Quotes::Shakespeare.hamlet_quote, content:Faker::Lorem.paragraph, user_id:User.all.sample.id)
end

10.times do
	Tag.create(title:Faker::GreekPhilosophers.name)
end

Gossip.all.each {|item| JoinGossipTag.create(gossip_id:item.id, tag_id:Tag.all.sample.id)}

20.times do
	PrivateMessage.create(content: Faker::Movies::StarWars.quote, user_id: User.all.sample.id)
end

25.times do
	JoinPmRecipient.create(private_message_id: PrivateMessage.all.sample.id, user_id: User.all.sample.id)
end

20.times do
	Comment.create(content: Faker::Movies::Lebowski.quote, gossip_id:Gossip.all.sample.id, user_id: User.all.sample.id)
end

#JoinPmRecipient.where(user_id: User.find_by(first_name: "Juanita").id).map{|item| PrivateMessage.find(item.private_message_id)} -> si tu veux connaitre les privates_messages reçus par Juanita...
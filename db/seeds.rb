# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Party.destroy_all
User.destroy_all

host = User.create(name: "Test Host", email: "host@test.com", password: 'test')
user_1 = User.create(name: "Test User", email: "test@test.com", password: 'test')
user_2 = User.create(name: "Test User2", email: "testuser@test.com", password: 'test')

Party.create(title: "Comet Party",
          date: "01-01-2019",
          description: "View Halley's Comet",
          street_address: "9357 W 26th Ave",
          city: "Wheat Ridge",
          state: "CO",
          zip_code: 80033,
          latitude: 39.754721,
          longitude: -105.1089577,
          host_id: host.id)

Party.create(title: "Nebula Party",
          date: "11-11-2018",
          description: "View Turing Nebula",
          street_address: "1700 N Sheridan Blvd",
          city: "Denver",
          state: "CO",
          zip_code: 80212,
          latitude: 39.744609,
          longitude: -105.0550696,
          host_id: host.id)

Party.create(title: "Meteor Party",
          date: "07-07-2020",
          description: "View Lovelace Meteor Shower",
          street_address: "15600 W Morrison Rd",
          city: "Lakewood",
          state: "CO",
          zip_code: 80228,
          latitude: 39.6497555,
          longitude: -105.1629224,
          host_id: host.id)

Party.create(title: "Meteor Party",
          date: "07-08-2019",
          description: "View Lovelace Meteor Shower",
          street_address: "980 Grant Street",
          city: "Denver",
          state: "CO",
          zip_code: 80203,
          latitude: 39.731650,
          longitude: -104.983180,
          host_id: host.id)

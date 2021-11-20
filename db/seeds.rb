# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Location.create(name: '810')
Location.create(name: 'SL')
Location.create(name: '49th')

fire_factory = Location.where(name: '810').first
sl = Location.where(name: 'SL').first
forty_ninth = Location.where(name: '49th').first

User.create(location: fire_factory, first_name: 'Tim', last_name: 'Spelone', authorization_level: 'Admin', email: '810veg@true-vision.co', password: 'admin1', initials: 'TS')

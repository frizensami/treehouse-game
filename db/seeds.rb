# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create all the houses with rake db:seed
House.create(name: "shan", floor_start: 4, floor_end: 7)
House.create(name: "ora", floor_start: 8, floor_end: 11)
House.create(name: "gaja", floor_start: 12, floor_end: 14)
House.create(name: "tancho", floor_start: 15, floor_end: 18)
House.create(name: "ponya", floor_start: 19, floor_end: 21)

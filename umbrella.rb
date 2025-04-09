require "http"
require "json"
require "dotenv/load"

puts "========================================"
puts "Will you need an umbrella today?"
puts "========================================\n"
puts "Where are you?"
location = gets.chomp
puts"Checking the weather at #{location}..."

gmaps_key = ENV.fetch("GMAPS_KEY")

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + location + "&key=" + gmaps_key

raw_gmaps = HTTP.get(gmaps_url)

parsed_gmaps = JSON.parse(raw_gmaps)
results_array = parsed_gmaps.fetch("results")
results_hash = results_array[0]
geometry_hash = results_hash.fetch("geometry")
location_hash = geometry_hash.fetch("location")

lat = location_hash.fetch("lat").to_s
lng = location_hash.fetch("lng").to_s

puts "Your coordinates are #{lat}, #{lng}."

coordinates = "/" + lat + "," + lng

pirate_weather_key = ENV.fetch("PIRATE_WEATHER_KEY")


pirate_url = "https://api.pirateweather.net/forecast/" + pirate_weather_key + "/" + coordinates
raw_pirate = HTTP.get(pirate_url)
parsed_pirate = JSON.parse(raw_pirate)
currently_hash = parsed_pirate.fetch("currently")
temp = currently_hash.fetch("temperature")

puts "It is currently #{temp}°F"

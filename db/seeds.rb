require 'date'
require 'pry'
puts "🌱 Seeding spices..."
# Seed your database here
start_date = Apod.last == nil ? "1995-06-16" : (Date.parse(Apod.last.date) + 1.day).strftime("%F")
# start_date = "1995-06-16"
end_date = (Date.parse(start_date) + 6.months).strftime("%F")

while Date.parse(start_date) <= Date.today do

  responses = RestClient.get "https://api.nasa.gov/planetary/apod?start_date=#{start_date}&end_date=#{end_date}&api_key=ousVxXPBdjpMGLhVTASFubjk0WQNgZ8OpKuBMzkg"

  apod_hashes = JSON.parse(responses)

  apod_hashes.each do |apod_hash|

    Apod.create(
      date: apod_hash["date"],
      explanation: apod_hash["explanation"],
      hdurl: apod_hash["hdurl"],
      media_type: apod_hash["media_type"],
      service_version: apod_hash["service_version"],
      title: apod_hash["title"],
      url: apod_hash["url"]
    )
  end

  start_date = (Date.parse(end_date) + 1.day).strftime("%F")
  end_date = (Date.parse(start_date) + 6.months) <= Date.today ? (Date.parse(start_date) + 6.months).strftime("%F") : Date.today.strftime("%F")

end

puts "✅ Done seeding!"

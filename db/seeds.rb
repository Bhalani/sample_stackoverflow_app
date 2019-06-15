require 'csv'
require 'open-uri'

CSV.foreach(open("https://drive.google.com/uc?export=download&id=1BViyRso0B4GzwE0zZ9JYAkDLTpxUSYf6")) do |row|
  ActsAsTaggableOn::Tag.create(name: row.first)
end

User.create(name: "Admin", email: "admin@sampleso.com", password: "password", role: 1)

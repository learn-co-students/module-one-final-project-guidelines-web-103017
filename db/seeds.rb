require "HTTParty"
url = "https://data.ny.gov/resource/vn2g-zyb7.json"
page_data = HTTParty.get(url)
responses = page_data.parsed_response

def fish_to_array(string)
  string.split("-").collect{|x|x.strip.downcase}
end

responses.each do |row|
  water_id = Waterbody.find_or_create_by(name: row["water"].downcase).id
  fish_to_array(row["fish_speci"]).each do |fish|
    #binding.pry
    fish_id = Fish.find_or_create_by(name: fish).id
    WaterbodyFish.create(waterbody_id: water_id, fish_id: fish_id)
  end
end


def county_to_array(string)
  string.split("/").collect{|x|x.strip.downcase}
end

responses.each do |row|
  water_id = Waterbody.find_or_create_by(name: row["water"].downcase).id
  county_to_array(row["county"]).each do |county|
    #binding.pry
    county_id = County.find_or_create_by(name: county).id
    CountyWaterbody.create(waterbody_id: water_id, county_id: county_id)
  end
end

def amenity_to_array(string)
  string.split("-").collect{|x|x.strip.downcase}
end

responses.each do |row|
  water_id = Waterbody.find_or_create_by(name: row["water"].downcase).id
  if row["ammenities"]
    amenity_to_array(row["ammenities"]).each do |amenity|
      #binding.pry
      amenity_id = Amenity.find_or_create_by(name: amenity).id
      WaterbodyAmenity.create(waterbody_id: water_id, amenity_id: amenity_id)
    end
  end
end

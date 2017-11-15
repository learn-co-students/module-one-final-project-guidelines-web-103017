require "HTTParty"
url = "https://data.ny.gov/resource/vn2g-zyb7.json"
page_data = HTTParty.get(url)
responses = page_data.parsed_response

# counties = responses.collect{|x| x["county"].downcase}.uniq
# # when done go back and look for slashes, which indicate 2 counties (e.g. "Broome/Delaware")
# counties.each do |x|
#   County.create(name: x)}
# end
# # makes all County instances
#
# waterbodies = responses.collect{|x| x["water"].downcase}.uniq
# waterbodies.each{|x| Waterbody.create(name: x)}
#
# fishes_dirty = responses.collect{|x| x["fish_speci"]}
# # pulls all fishes from responses
# fishes_clean = fishes_dirty.join("-").split("-").collect{|x|x.strip.downcase}.uniq.sort
# # fish_speci from api is currently separated by hyphens. we join all response entires
# # and then split by hypen to get array of all fishes in all lakes, then remove whitespace
# # and run uniq to get unique list.
# fishes_clean.each{|x| Fish.create(name: x)}
# # makes all fish instances

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

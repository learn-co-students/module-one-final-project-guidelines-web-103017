require "HTTParty"
url = "https://data.ny.gov/resource/vn2g-zyb7.json"
page_data = HTTParty.get(url)
responses = page_data.parsed_response

counties = responses.collect{|x| x["county"]}.uniq
# when done go back and look for slashes, which indicate 2 counties (e.g. "Broome/Delaware")
counties.each{|x| County.create(x})}
# makes all County instances

fishes_dirty = responses.collect{|x| x["fish_speci"]}
# pulls all fishes from responses
fishes_clean = fishes_dirty.join("-").split("-").collect{|x|x.strip.downcase}.uniq.sort
# fish_speci from api is currently separated by hyphens. we join all response entires
# and then split by hypen to get array of all fishes in all lakes, then remove whitespace
# and run uniq to get unique list.
fishes_clean.each{|x| County.create(x})}
# makes all fish instances

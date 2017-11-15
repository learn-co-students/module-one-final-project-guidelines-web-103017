require 'pry'
# Beer.destroy_all
#
# def seed_beers
#   key = "&key=c7eeca86b7a750a8aec2f89d33460b52"
#   beers_url = "http://api.brewerydb.com/v2/beers/?withIngredients=Y#{key}"
#
#   num_pages = JSON.parse(RestClient.get(beers_url))["numberOfPages"]
#
#   counter = 1
#   while counter <= num_pages
#     beer_url = "http://api.brewerydb.com/v2/beers/?p=#{counter}&withIngredients=Y#{key}"
#
#     if JSON.parse(RestClient.get(beer_url))["status"] == "success"
#       all_beers = JSON.parse(RestClient.get(beer_url))["data"]
#
#       all_beers.each do |beer|
#         Beer.create(
#           name: beer.fetch("name", ""),
#           style: beer.dig("style", "name") ? beer["style"]["name"] : "",
#           abv: beer.fetch("abv", 0).to_i,
#           description: beer.dig("style", "description") ? beer["style"]["description"] : "",
#           isorganic: beer.fetch("isOrganic", ""),
#           rating: 0,
#           api_key: beer.fetch("id", "")
#           )
#           end
#         counter += 1
#     else
#       counter += 1
#     end
#   end
# end
#
# seed_beers

Brewery.destroy_all

def seed_breweries
  key = "&key=c7eeca86b7a750a8aec2f89d33460b52"
  breweries_url = "http://api.brewerydb.com/v2/breweries/?withLocations=Y#{key}"

  num_pages = JSON.parse(RestClient.get(breweries_url))["numberOfPages"]

  counter = 1
  while counter <= num_pages
    brewery_url = "http://api.brewerydb.com/v2/breweries/?p=#{counter}&withLocations=Y#{key}"

    if JSON.parse(RestClient.get(brewery_url))["status"] == "success"
      all_breweries = JSON.parse(RestClient.get(brewery_url))["data"]

      all_breweries.each do |brewery|

        Brewery.create(
          name: brewery.fetch("name", ""),
          description: brewery.fetch("description", ""),
          classification: brewery.fetch("brandClassification", ""),
          established: brewery.fetch("established", 0000).to_i,
          website: brewery.fetch("website", ""),
          latitude: brewery["locations"].first.fetch("latitude", 0.0),
          longitude: brewery["locations"].first.fetch("longitude", 0.0), address: brewery["locations"].first.fetch("streetAddress", ""),
          city: brewery["locations"].first.fetch("locality", ""),
          state: brewery["locations"].first.fetch("region", ""),
          country: brewery["locations"].first.fetch("countryIsoCode", ""),
          postalcode: brewery["locations"].first.fetch("postalCode", ""),
          api_key: brewery.fetch("id", "")
          )
          end
        counter += 1
    else
      counter += 1
    end
  end
end

seed_breweries

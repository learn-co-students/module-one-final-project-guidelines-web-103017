
User.create(name: 'Brendan McIlhenny', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')
User.create(name: 'Christofer Johnson', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')
User.create(name: 'Connie Wang', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')
User.create(name: 'Dan O Dea', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')
User.create(name: 'Ellisa Shim', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')
User.create(name: 'Erica Li', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')
User.create(name: 'Erick Camacho', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')
User.create(name: 'George Gore', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')
User.create(name: 'Greg Driza', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')
User.create(name: 'Jake MacNaughton', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')
User.create(name: 'Jon Wu', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')
User.create(name: 'Josh Stillman', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')
User.create(name: 'Joshua Wasserman', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')
User.create(name: 'Katerina Papacostas', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')
User.create(name: 'Paul Kristapovich', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')
User.create(name: 'Priyam Sarma', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')
User.create(name: 'Rochel Levi', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')
User.create(name: 'Seth Barden', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')
User.create(name: 'Silvia Chung', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')
User.create(name: 'Tashawn Williams', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')
User.create(name: 'Yuliya Yasenetska', city: 'New York', state: 'New York', zipcode: 10019, country: 'United States')

# # User 1 has many favorited / rated beers
# UserBeer.create(beer_id: 14, user_id: 1, rating: 5)
# UserBeer.create(beer_id: 28, user_id: 1, rating: 4)
# UserBeer.create(beer_id: 30, user_id: 1, rating: 3)
# UserBeer.create(beer_id: 44, user_id: 1, rating: 5)
# UserBeer.create(beer_id: 58, user_id: 1, rating: 5)
#
# # Many ratings for many beers
# UserBeer.create(beer_id: 6, user_id: 2, rating: 5)
# UserBeer.create(beer_id: 7, user_id: 2, rating: 3)
# UserBeer.create(beer_id: 8, user_id: 2, rating: 2)
# UserBeer.create(beer_id: 9, user_id: 2, rating: 5)
#
# UserBeer.create(beer_id: 22, user_id: 3, rating: 1)
# UserBeer.create(beer_id: 17, user_id: 3, rating: 4)
# UserBeer.create(beer_id: 19, user_id: 4, rating: 2)
#
# # Beer 14 has many ratings from many users
# UserBeer.create(beer_id: 14, user_id: 5, rating: 2)
# UserBeer.create(beer_id: 14, user_id: 6, rating: 3)
# UserBeer.create(beer_id: 14, user_id: 7, rating: 5)
#
# UserBeer.create(beer_id: 20, user_id: 1, rating: 5)

# Brewery.destroy_all
#
# def seed_breweries
#   key = "&key=c7eeca86b7a750a8aec2f89d33460b52"
#   breweries_url = "http://api.brewerydb.com/v2/breweries/?withLocations=Y#{key}"
#
#   num_pages = JSON.parse(RestClient.get(breweries_url))["numberOfPages"]
#
#   counter = 1
#   while counter <= num_pages
#     brewery_url = "http://api.brewerydb.com/v2/breweries/?p=#{counter}&withLocations=Y#{key}"
#
#     if JSON.parse(RestClient.get(brewery_url))["status"] == "success"
#       all_breweries = JSON.parse(RestClient.get(brewery_url))["data"]
#
#       all_breweries.each do |brewery|
#         if brewery["locations"] != nil
#           Brewery.create(
#             name: brewery.fetch("name", ""),
#             description: brewery.fetch("description", ""),
#             classification: brewery.fetch("brandClassification", ""),
#             established: brewery.fetch("established", 0000).to_i,
#             website: brewery.fetch("website", ""),
#             latitude: brewery["locations"].first.fetch("latitude", 0.0),
#             longitude: brewery["locations"].first.fetch("longitude", 0.0),
#             address: brewery["locations"].first.fetch("streetAddress", ""),
#             city: brewery["locations"].first.fetch("locality", ""),
#             state: brewery["locations"].first.fetch("region", ""),
#             country: brewery["locations"].first.fetch("countryIsoCode", ""),
#             postalcode: brewery["locations"].first.fetch("postalCode", ""),
#             api_key: brewery.fetch("id", "")
#             )
#           end
#         end
#         counter += 1
#     else
#       counter += 1
#     end
#   end
# end

# seed_breweries

# Beer.destroy_all
#
# def seed_beers
#   Brewery.all.each do |brewery|
#     brewery_key = brewery.api_key
#     key = "?key=c7eeca86b7a750a8aec2f89d33460b52"
#     brewery_beers_url = "http://api.brewerydb.com/v2/brewery/#{brewery_key}/beers/#{key}"
#
#     if JSON.parse(RestClient.get(brewery_beers_url))["status"] == "success"
#       all_beers = JSON.parse(RestClient.get(brewery_beers_url))["data"]
#       if all_beers != nil
#         all_beers.each do |beer|
#           Beer.create(
#             name: beer.fetch("name", ""),
#             style: beer.dig("style", "name") ? beer["style"]["name"] : "",
#             abv: beer.fetch("abv", 0).to_i,
#             description: beer.dig("style", "description") ? beer["style"]["description"] : "",
#             isorganic: beer.fetch("isOrganic", ""),
#             rating: 0,
#             api_key: beer.fetch("id", ""),
#             brewery_id: brewery.id
#             )
#         end
#       end
#     end
#   end
# end
#
# seed_beers

# #<-- SEED INGREDIENTS ->

# def seed_ingredients
#   key = "&key=c7eeca86b7a750a8aec2f89d33460b52"
#   ingredients_url = "http://api.brewerydb.com/v2/ingredients/?#{key}"
#   # cap it at 20?
#   num_pages = JSON.parse(RestClient.get(ingredients_url))["numberOfPages"]

#   counter = 1
#   while counter <= num_pages
#     ingredient_url = "http://api.brewerydb.com/v2/ingredients/?p=#{counter}#{key}"

#     if JSON.parse(RestClient.get(ingredient_url))["status"] == "success"
#       all_ingredients = JSON.parse(RestClient.get(ingredient_url))["data"]

#       all_ingredients.each do |ingredient|
#         Ingredient.create(
#           name: ingredient.fetch("name", ""),
#           api_id: ingredient.fetch("id", 0))
#         end
#         counter += 1
#     else
#       counter += 1
#     end
#   end
# end

# seed_ingredients

# <-- SEED BEER INGREDIENTS -->
# Beeringredient.destroy_all
#
# def seed_beeringredients
#   Beer.all.each do |beer|
#     beerkey = beer.api_key
#     beeringredient_url = "http://api.brewerydb.com/v2/beer/#{beerkey}/ingredients/?key=c7eeca86b7a750a8aec2f89d33460b52"
#     if JSON.parse(RestClient.get(beeringredient_url))["status"] == "success"
#       beeringredients = JSON.parse(RestClient.get(beeringredient_url))["data"]
#       if beeringredients != nil
#         beeringredients.each do |beeringredient|
#           if Ingredient.find_by(api_id: "#{beeringredient["id"]}") != nil
#             Beeringredient.create(
#             beer_id: beer.id,
#             ingredient_id: Ingredient.find_by(api_id: "#{beeringredient["id"]}").id
#           )
#           end
#         end
#       end
#     end
#   end
# end
#
# seed_beeringredients

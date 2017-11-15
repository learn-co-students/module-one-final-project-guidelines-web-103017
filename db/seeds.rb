Beer.destroy_all

def seed_beers
  key = "&key=c7eeca86b7a750a8aec2f89d33460b52"
  beers_url = "http://api.brewerydb.com/v2/beers/?withIngredients=Y#{key}"

  num_pages = JSON.parse(RestClient.get(beers_url))["numberOfPages"]

  counter = 1
  while counter <= 10 #num_pages
    beer_url = "http://api.brewerydb.com/v2/beers/?p=#{counter}&withIngredients=Y#{key}"

    if JSON.parse(RestClient.get(beer_url))["status"] == "success"
      all_beers = JSON.parse(RestClient.get(beer_url))["data"]

      all_beers.each do |beer|
        Beer.create(
          name: beer.fetch("name", ""),
          style: beer.dig("style", "name") ? beer["style"]["name"] : "",
          abv: beer.fetch("abv", 0).to_i,
          description: beer.dig("style", "description") ? beer["style"]["description"] : "",
          isorganic: beer.fetch("isOrganic", ""),
          rating: 0,
          api_key: beer.fetch("id", "")
          )
          end
        counter += 1
    else
      counter += 1
    end
  end
end

seed_beers


# #<-- SEED INGREDIENTS ->

def seed_ingredients
  key = "&key=c7eeca86b7a750a8aec2f89d33460b52"
  ingredients_url = "http://api.brewerydb.com/v2/ingredients/?#{key}"
  # cap it at 20?
  num_pages = JSON.parse(RestClient.get(ingredients_url))["numberOfPages"] 

  counter = 1
  while counter <= num_pages
    ingredient_url = "http://api.brewerydb.com/v2/ingredients/?p=#{counter}#{key}"

    if JSON.parse(RestClient.get(ingredient_url))["status"] == "success"
      all_ingredients = JSON.parse(RestClient.get(ingredient_url))["data"]

      all_ingredients.each do |ingredient|
        Ingredient.create(
          name: ingredient.fetch("name", ""),
          api_id: ingredient.fetch("id", 0))
        end
        counter += 1
    else
      counter += 1
    end
  end
end

seed_ingredients

# <-- SEED BEER INGREDIENTS --> 
Beeringredient.destroy_all

def seed_beeringredients
  Beer.all.each do |beer|
    beerkey = beer.api_key
    beeringredient_url = "http://api.brewerydb.com/v2/beer/#{beerkey}/ingredients/?key=c7eeca86b7a750a8aec2f89d33460b52"
    if JSON.parse(RestClient.get(beeringredient_url))["status"] == "success"
      beeringredients = JSON.parse(RestClient.get(beeringredient_url))["data"]
      if beeringredients != nil

        beeringredients.each do |beeringredient|
          Beeringredient.create(
          beer_id: beer.id,
          ingredient_id: Ingredient.find_by(api_id: "#{beeringredient["id"]}").id
        )
        end
      end
    end
  end
end

seed_beeringredients

























  



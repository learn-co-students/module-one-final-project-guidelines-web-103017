class DbSeed

  KEY = "?key=c7eeca86b7a750a8aec2f89d33460b52"
  BASE_API = "http://api.brewerydb.com/v2"

  def self.seed_breweries(pages=10)
    Brewery.destroy_all
    breweries_url = "#{BASE_API}/breweries/#{KEY}&withLocations=Y"
    num_pages = self.total_pages(breweries_url)

    counter = 1
    while counter <=  (pages < num_pages ? pages : num_pages) 
      brewery_url = "#{BASE_API}/breweries/#{KEY}&p=#{counter}&withLocations=Y"

      if self.http_success(brewery_url)
        all_breweries = self.api_data(brewery_url)

        all_breweries.each do |brewery|
          if brewery["locations"] != nil
            Brewery.create(
              name: brewery.fetch("name", ""),
              description: brewery.fetch("description", ""),
              classification: brewery.fetch("brandClassification", ""),
              established: brewery.fetch("established", 0000).to_i,
              website: brewery.fetch("website", ""),
              latitude: brewery["locations"].first.fetch("latitude", 0.0),
              longitude: brewery["locations"].first.fetch("longitude", 0.0),
              address: brewery["locations"].first.fetch("streetAddress", ""),
              city: brewery["locations"].first.fetch("locality", ""),
              state: brewery["locations"].first.fetch("region", ""),
              country: brewery["locations"].first.fetch("countryIsoCode", ""),
              postalcode: brewery["locations"].first.fetch("postalCode", ""),
              api_key: brewery.fetch("id", "")
              )
            end
          end
          counter += 1
      else
        counter += 1
      end
    end
  end

  def self.seed_beers
    Beer.destroy_all
    Brewery.all.each do |brewery|
      brewery_key = brewery.api_key
      brewery_beers_url = "#{BASE_API}/brewery/#{brewery_key}/beers/#{KEY}"

      if self.http_success(brewery_beers_url)
        all_beers = self.api_data(brewery_beers_url)
        if all_beers != nil
          all_beers.each do |beer|
            Beer.create(
              name: beer.fetch("name", ""),
              style: beer.dig("style", "name") ? beer["style"]["name"] : "",
              abv: beer.fetch("abv", 0).to_i,
              description: beer.dig("style", "description") ? beer["style"]["description"] : "",
              isorganic: beer.fetch("isOrganic", ""),
              api_key: beer.fetch("id", ""),
              brewery_id: brewery.id
              )
          end
        end
      end
    end
  end

  def self.seed_ingredients
    Ingredient.destroy_all

    ingredients_url = "#{BASE_API}/ingredients/#{KEY}"
    # cap it at 20?
    num_pages = self.total_pages(ingredients_url)

    counter = 1
    while counter <= num_pages
      ingredient_url = "#{BASE_API}/ingredients/#{KEY}&p=#{counter}"

      if self.http_success(ingredient_url)
        all_ingredients = self.api_data(ingredient_url)

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

  def self.seed_beeringredients
    BeerIngredient.destroy_all
    Beer.all.each do |beer|
      beerkey = beer.api_key
      beeringredient_url = "#{BASE_API}/beer/#{beerkey}/ingredients/#{KEY}"
      if self.http_success(beeringredient_url)
        beeringredients = self.api_data(beeringredient_url)
        if beeringredients != nil
          beeringredients.each do |beeringredient|
            if Ingredient.find_by(api_id: "#{beeringredient["id"]}") != nil
              BeerIngredient.create(
              beer_id: beer.id,
              ingredient_id: Ingredient.find_by(api_id: "#{beeringredient["id"]}").id
            )
            end
          end
        end
      end
    end
  end

  private

  def self.total_pages(url)
    JSON.parse(RestClient.get(url))["numberOfPages"]
  end

  def self.http_success(url)
    JSON.parse(RestClient.get(url))["status"] == "success"
  end

  def self.api_data(url)
    JSON.parse(RestClient.get(url))["data"]
  end

end

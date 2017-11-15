Beer.destroy_all

def seed_beers
  key = "&key=c7eeca86b7a750a8aec2f89d33460b52"
  beers_url = "http://api.brewerydb.com/v2/beers/?withIngredients=Y#{key}"

  num_pages = JSON.parse(RestClient.get(beers_url))["numberOfPages"]

  counter = 1
  while counter <= num_pages
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



  



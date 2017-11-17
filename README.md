# Beer Bud - Module One Final Project
```
__          __  _                            _          ____                   ____            _ 
 \ \        / / | |                          | |        |  _ \                 |  _ \          | |
  \ \  /\  / /__| | ___ ___  _ __ ___   ___  | |_ ___   | |_) | ___  ___ _ __  | |_) |_   _  __| |
   \ \/  \/ / _ \ |/ __/ _ \| '_ ` _ \ / _ \ | __/ _ \  |  _ < / _ \/ _ \ '__| |  _ <| | | |/ _` |
    \  /\  /  __/ | (_| (_) | | | | | |  __/ | || (_) | | |_) |  __/  __/ |    | |_) | |_| | (_| |
     \/  \/ \___|_|\___\___/|_| |_| |_|\___|  \__\___/  |____/ \___|\___|_|    |____/ \__,_|\__,_|
                                                                                               
```

## App Description

Beer Bud is your best friend when it comes to finding local breweries and beers! Beer Bud allows you to search for breweries by location (City and Zip Code). Beer bud allows you to find beers from your favorite breweries, by keyword, and the highest rated beers in our user database. Beer Bud allows you to save and rate your favorite beers to your profile.

The scope of our data is pulled from the BreweryDB API, available at http://www.brewerydb.com/developers
The API has roughly the following volumes of data:
  - Beers: 70,000+ individual beers
  - Breweries: 9500+ individual breweries

The API allows you to page through the data, returning 50 records per page

### Install Instructions

#### Running App with sample set of data
1. Git clone the repository
2. Run `rake db:migrate` from the top level directory of the project
3. Run `rake db:seed` from the top level directory of the project
4. To populate the database with sample data:
    - use Rake -T to view options
    - run these rake tasks in the following order:
    - rake populate:breweries_sample n
        -n is the number of random pages you wish to seed from the API; we recommend 5 or less (the default value is 10)
    - rake populate:beers
    - rake populate:ingredients
    - rake populate user_beers
        -user_beers does take an optional argument if you would like to specify the number of randomly populated user_beer instances (the default value is 100)
    - rake populate beer_ingredients
5. The run file is in bin/run.rb - type `ruby bin/run.rb` from the top level directory of the project to run Beer Bud!



#### Running App with full volume of data
  1. Git clone the repository
  2. Run `rake db:migrate` from the top level directory of the project
  3. Run `rake db:seed` from the top level directory of the project
  4. To populate the database with sample data:
      - use Rake -T to view options
      - run these rake tasks in the following order:
      - rake populate:breweries
          -(note: this will populate your database with the full volume of 9500+ breweries from the API, which means that the corresponding counts of beers and beer ingredients will be quite significant and may take some time.)
      - rake populate:beers
      - rake populate:ingredients
      - rake populate user_beers
          -user_beers does take an optional argument if you would like to specify the number of randomly populated user_beer instances (the default value is 100)
      - rake populate beer_ingredients
5. The run file is in bin/run.rb - type `ruby bin/run.rb` from the top level directory of the project to run Beer Bud!


### Contributors Guide
This project is licensed under the MIT license. See LICENSE.txt for more details.


Contributors: Connie Wang, Priyam Sarma

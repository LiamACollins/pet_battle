# README

Ruby version: 2.7.5

Docs for the Wunder API used can be found here: https://github.com/wunderteam/battle-pets-api
Endpoint of the Wunder API: https://wunder-pet-api-staging.herokuapp.com

The battle pets app handles post and get requests from the demo_script.rb file and all endpoints are in JSON. The demo script can be accessed [here](https://github.com/wunderteam/battle-pets-arena/archive/master.zip).

# Setting up the App:

  ## Install dependencies
  ````bundle install````

  ## Setup database
  ````bundle exec rake db:create````<br/>
  ````bundle exec rake db:migrate````

  ## Start server
  ````bundle exec rails s -p 3000````

# README

![CI](https://github.com/olegsta/receipt_test/actions/workflows/code-style.yml/badge.svg)

ADMIN PANEL for user http://94.237.101.229/admin/user

<p>
  <img src="https://github.com/olegsta/receipt_test/blob/master/public/1.png" width="600" title="hover text">
  <img src="https://github.com/olegsta/receipt_test/blob/master/public/2.png" width="600" alt="accessibility text">
  <img src="https://github.com/olegsta/receipt_test/blob/master/public/3.png" width="600" alt="accessibility text">
</p>

JSON API with Ruby on Rails framework with user admin panel

* Ruby version: 3.0.1
* Rails version: 6.1.7.3
* Docker
* Docker-Compose
* Database: Postgresql 14


* How to run:
```
  docker-compose build
  docker-compose run receipt bundle install
  docker-compose run receipt rake db:drop db:create db:migrate db:seed
  docker-compose up
  docker-compose up -d (on prod mode)
```

<b>Run tests</b>: <br>
```
  docker-compose run receipt rake db:test:prepare
  docker-compose run receipt bundle exec rspec
```

<b>Endpoints</b>: <br>
```
  Admin Panel:                 /admin                                      RailsAdmin::Engine
  World Leaders users   GET    /api/v1/users/world_leaders(.:format)       api/v1/users#world_leaders
  Country Leaders users GET    /api/v1/users/country_leaders(:format)      api/v1/users#country_leaders
  Create new users      POST   /api/v1/users(.:format)                     api/v1/users#create                  
  Create new ratings    POST   /api/v1/ratings(.:format)                   api/v1/ratings#create     
```
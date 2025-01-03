# README

![CI](https://github.com/olegsta/receipt_test/actions/workflows/code-style.yml/badge.svg)
![CI](https://github.com/olegsta/receipt_test/actions/workflows/rspec.yml/badge.svg)

Endpoint for receive recipes http://94.237.82.85/recipes/generate

<p>
  <img src="https://github.com/olegsta/receipt_test/blob/main/public/1.png" width="600" title="hover text">
  <img src="https://github.com/olegsta/receipt_test/blob/main/public/2.png" width="600" alt="accessibility text">
  <img src="https://github.com/olegsta/receipt_test/blob/main/public/3.png" width="600" alt="accessibility text">
</p>

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
  Receive new recipes    POST   /recipes/generate(.:format)                   recipes#generate
```
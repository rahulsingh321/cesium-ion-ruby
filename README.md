<!-- Write your README.md file. Build something amazing! This README.md template can guide you to build your project documentation, but feel free to modify it as you wish 🥰 -->
# **Cesium Ion Ruby**
This gem wraps the Cesium Ion REST APIs for convenient access from ruby applications.

Cesium Ion REST API documentation - https://cesium.com/learn/ion/rest-api
## **About**

A ruby gem that provides ability to implement the [cesium ion rest apis](https://cesium.com/learn/ion/rest-api/).

## **Key Features**

* It includes the authentication both via Oauth 2.0 and using account access token.
* Includes following rest apis of cesium ion - 
  a) Create Asset
  b) Upload Asset
* Easy to configure and use.

## **Demo**

## **Installation**

1. Add this gem to your Gemfile with this line:

    ```ruby
    gem 'cesium-ion-ruby'
    ```

2. Install the gem using Bundler

    ```ruby
    bundle install
    ```

3. Copy & run migrations

    ```ruby
    bundle exec rails g cesium-ion-ruby:install
    ```

4. Restart your server!

  If your server was running, restart it so that it can find the assets properly.


## Testing

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle update
bundle exec rake
```


When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'cesium-ion-ruby/factories'
```
---

## Contributing

[See corresponding guidelines](https://github.com/rahulsingh321/cesium-ion-ruby/blob/master/CONTRIBUTING.md)

---

Copyright (c) 2023 Rahul Singh. released under the [New BSD License](https://github.com/rahulsingh321/cesium-ion-ruby/blob/master/LICENSE)

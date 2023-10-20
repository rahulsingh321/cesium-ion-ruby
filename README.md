<!-- Write your README.md file. Build something amazing! This README.md template can guide you to build your project documentation, but feel free to modify it as you wish 🥰 -->
# **Cesium Ion Ruby**
This gem wraps the Cesium Ion REST APIs for convenient access from ruby applications.

Cesium Ion REST API documentation - https://cesium.com/learn/ion/rest-api
## **About**

A ruby gem that provides ability to implement the [cesium ion rest apis](https://cesium.com/learn/ion/rest-api/).

## **Key Features**

* It includes the authentication via accounts access token.
* Includes following rest apis of cesium ion - 
  a) Assets APIs
    - Create Assets
    - List Assets
    - Show Asset
    - Update Asset
    - Destroy Asset
    - Access Tile
  b) Archieve APIs
    - Create Archieves
    - Show Archieves
    - List Archieves
    - Destroy Archieves
  c) Export APIs
    - Create Export
    - Show Exports
    - List Exports
  d) Tokens APIs
    - Create Token
    - List Token
    - Show Token
    - Update Token
* Easy to configure and use.

## **Example Usage**
  ### **Assets API**
  ```ruby
    CesiumIon::Assets::Create.new({name: "New Asset", description: "The moon is gradually moving away from Earth. This phenomenon is known as lunar recession.", attribution: "Picture of a moon", type: "3DTILES", "options": {"sourceType": "3D_CAPTURE"}}).response
    CesiumIon::Assets::Index.new().response
    CesiumIon::Assets::Show.new({asset_id: 1814445}).response
    CesiumIon::Assets::Update.new({asset_id: 1814445, name: "New Asset 2", description: "Linar Recession", attribution: "Picture of a moon from space"}).response
    CesiumIon::Assets::Destroy.new({asset_id: 1777847}).response
    CesiumIon::Assets::AccessTile.new({asset_id: 1814445}).response
  ```

  ### **Archieve API**
  ```ruby
  CesiumIon::Archives::Index.new({asset_id: 1814445}).response
  CesiumIon::Archives::Create.new({asset_id: 1814445}).response
  CesiumIon::Archives::Show.new({asset_id: 1814445, archive_id: 36881 }).response
  CesiumIon::Archives::Destroy.new({asset_id: 1814445, archive_id: 36881 }).response
  ```

  ### **Tokens API**
  ```ruby
    CesiumIon::Tokens::Index.new().response
    CesiumIon::Tokens::Show.new({token_id: "03e9fea4-7f3d-484b-bfc2-ac46c286eb6b"}).response
    CesiumIon::Tokens::Create.new({name: "New token", scopes: ["assets:list"]}).response
    CesiumIon::Tokens::Destroy.new({token_id: "03e9fea4-7f3d-484b-bfc2-ac46c286eb6b"}).response
    CesiumIon::Tokens::Update.new({token_id: "03e9fea4-7f3d-484b-bfc2-ac46c286eb6b", name: "Updated Token", scopes: ["assets:list"]}).response
  ```


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

4. Once you install the gem a file named as cesium_ion.rb will be created add the following there.
    ```ruby
    require 'cesium_ion'

    CesiumIon.configure do |config|
      config.auth_token = "Bearer token"
    end
    ```
4. Restart your server!

  If your server was running, restart it so that it can find the assets properly.

## Contributing

[See corresponding guidelines](https://github.com/rahulsingh321/cesium-ion-ruby/blob/master/CONTRIBUTING.md)

---

Copyright (c) 2023 Rahul Singh. released under the [New BSD License](https://github.com/rahulsingh321/cesium-ion-ruby/blob/master/LICENSE)

# Bouncer
Bouncer is an easy-to-use authentication solution that uses Auth0.

## Preconditions
You need to have decided on a name for your user class and created a table that contains the following columns:
- email:string
- first_name:string
- last_name:string
- uid:string (unique index)
- provider:string

Bouncer uses these columns to store the data received from Auth0.

## Getting started
Add the following to your application's Gemfile:

```ruby
gem "bouncer", github: "Synsbasen/bouncer", tag: "v0.1.0"
```

Then run `bundle install`.

Next, you need to run the generator:
```bash
$ rails g bouncer:install
```

This does the following:
- **Creates an initializer (config/initializers/bouncer.rb):** In here you need to tell Bouncer the name of your user class. Make sure to pass it as a string. Furthermore, you need to provide your credentials for Auth0. Save these credentials in an .env file (or using Rails credentials) for your own sake.
- **Mounts the Bouncer::Engine in routes (config/routes.rb):** No need to do anything futher here.
- **Includes the Bouncer::Authentication controller concern in your ApplicationController:** No need to do anything here, unless you don't have an ApplicationController.

Last, you need to install the migrations for events (we store whenever a user signs in or out):

```bash
$ rails bouncer:install:migrations
```

Then run `rails db:migrate` to migrate your database.

If you want your user class to be able to respond to events you can add the following to that model.

### Example
```ruby
class User < ApplicationRecord
  has_many :bouncer_events, as: :user, class_name: 'Bouncer::Event'
end
```

## Contributing
Feel free to submit a pull request. We have the ambition to support other providers than Auth0 as well.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

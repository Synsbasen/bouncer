module Bouncer
  module Generators
    class InstallGenerator < Rails::Generators::Base
      namespace "bouncer:install"

      def create_initializer_file
        initializer "bouncer.rb" do
          <<-TEXT
          Bouncer.auth0_client_id = 'YOUR_CLIENT_ID'
          Bouncer.auth0_client_secret = 'YOUR_CLIENT_SECRET'
          Bouncer.auth0_domain = 'YOUR_DOMAIN'
          Bouncer.auth0_authorize_params = {
            ui_locales: 'en',
            scope: 'openid profile email',
          }
          TEXT
        end
      end
    end
  end
end

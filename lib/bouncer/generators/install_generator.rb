module Bouncer
  module Generators
    class InstallGenerator < Rails::Generators::Base
      namespace "bouncer:install"

      def call
        # Create initializer file with default configuration options
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

        # Inject include Bouncer::Authentication in ApplicationController
        inject_into_class "app/controllers/application_controller.rb", "ApplicationController" do
          "  include Bouncer::Authentication\n"
        end
      end
    end
  end
end

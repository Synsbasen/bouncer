module Bouncer
  class Railtie < Rails::Railtie
    generators do
      require "bouncer/generators/install_generator"
    end
  end
end

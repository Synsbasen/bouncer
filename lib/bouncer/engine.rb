module Bouncer
  class Engine < ::Rails::Engine
    isolate_namespace Bouncer

    generators do
      require "bouncer/generators/install_generator"
    end
  end
end

require_relative "lib/bouncer/version"

Gem::Specification.new do |spec|
  spec.name        = "bouncer"
  spec.version     = Bouncer::VERSION
  spec.authors     = ["Jimmy Poulsen", "Tobias Knudsen"]
  spec.email       = ["jimmy@poulsen.dk", "tobias.knudsen@gmail.com"]
  spec.homepage    = "https://github.com/Synsbasen/bouncer"
  spec.summary     = "Library that provides a simple way to authenticate users using Auth0"
  spec.description = "Description of Bouncer."
  spec.license     = "MIT"

  spec.add_runtime_dependency "omniauth-auth0", "~> 3.0"
  spec.add_dependency "omniauth-rails_csrf_protection", "~> 1.0"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Synsbasen/bouncer"
  spec.metadata["changelog_uri"] = "https://github.com/Synsbasen/bouncer"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  # spec.add_dependency "rails", ">= 7.1.0.alpha"
end

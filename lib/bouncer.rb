require "bouncer/version"
require "bouncer/engine"

module Bouncer
  mattr_accessor :auth0_client_id, :auth0_client_secret, :auth0_domain, :auth0_authorize_params

  def self.ready?
    [auth0_client_id, auth0_client_secret, auth0_domain].all?(&:present?)
  end
end

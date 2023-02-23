require "bouncer/version"
require "bouncer/engine"

module Bouncer
  mattr_accessor :user_class,
                 :auth0_client_id,
                 :auth0_client_secret,
                 :auth0_domain,
                 :auth0_authorize_params

  def self.ready?
    [user_class, auth0_client_id, auth0_client_secret, auth0_domain].all?(&:present?)
  end

  def self.user_class
    @@user_class.constantize
  end
end

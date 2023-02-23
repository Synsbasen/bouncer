require "bouncer/version"
require "bouncer/engine"

module Bouncer
  REQUIRED_COLUMNS = %w[uid provider first_name last_name email].freeze

  mattr_accessor :user_class,
                 :auth0_client_id,
                 :auth0_client_secret,
                 :auth0_domain,
                 :auth0_authorize_params

  def self.ready?
    [user_class, auth0_client_id, auth0_client_secret, auth0_domain].all?(&:present?) &&
      all_required_columns_present?
  end

  def self.user_class
    @@user_class.constantize
  rescue NoMethodError => e
    raise "Bouncer.user_class is not set. Please set it in an initializer."
  rescue NameError => e
    raise "Bouncer.user_class is set to an invalid class name. Please set it to a valid class name"
  end

  private

  def self.all_required_columns_present?
    if missing_columns = REQUIRED_COLUMNS.difference(user_class.column_names).length > 0
      raise "Bouncer is missing the following columns: #{missing_columns.join(", ")}"
    else
      true
    end
  end
end

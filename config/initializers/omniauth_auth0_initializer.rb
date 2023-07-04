require "omniauth-auth0"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    Bouncer.auth0_client_id,
    Bouncer.auth0_client_secret,
    Bouncer.auth0_domain,
    callback_path: "/auth/auth0/callback",
    authorize_params: Bouncer.auth0_authorize_params
  )
end

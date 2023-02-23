Bouncer::Engine.routes.draw do
  mount Bouncer::Engine => '/'
  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"
  get "/auth/logout" => "auth0#logout"
  get "/auth/logout/callback" => "auth0#logout_callback"
end

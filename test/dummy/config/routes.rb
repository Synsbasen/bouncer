Rails.application.routes.draw do
  mount Bouncer::Engine => '/'
end

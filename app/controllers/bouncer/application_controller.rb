module Bouncer
  class ApplicationController < ActionController::Base
    include Authentication
  end
end

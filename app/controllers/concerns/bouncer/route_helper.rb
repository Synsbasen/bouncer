module Bouncer
  module RouteHelper
    extend ActiveSupport::Concern

    included do
      helper_method :bouncer_login_path
      helper_method :bouncer_logout_path
      helper_method :bouncer_signup_path
    end

    def bouncer_login_path(login_hint: nil)
      path = "/auth/auth0?screen_hint=login"
      path += "&login_hint=#{login_hint}" if login_hint
      path
    end

    def bouncer_logout_path
      "/auth/logout"
    end

    def bouncer_signup_path(login_hint: nil)
      path = "/auth/auth0?screen_hint=signup"
      path += "&login_hint=#{login_hint}" if login_hint
      path
    end
  end
end

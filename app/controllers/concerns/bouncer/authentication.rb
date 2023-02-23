module Bouncer
  module Authentication
    extend ActiveSupport::Concern

    included do
      helper_method :current_user
      helper_method :user_signed_in?

      after_action :store_latest_path
    end

    def sign_in(user)
      return false unless user && user.persisted?

      Bouncer::Event::SignIn.create(user: user, ip: request.remote_ip)

      session[:bouncer_user_id] = user.id
    end

    def sign_out
      Bouncer::Event::SignOut.create(user: current_user, ip: request.remote_ip) if current_user.present?

      reset_session
    end

    def authenticate_user!
      redirect_to "/" unless user_signed_in?
    end

    private

    def current_user
      Current.user ||= session[:bouncer_user_id] && User.find_by_id(session[:bouncer_user_id])
    end

    def user_signed_in?
      current_user.present?
    end

    def store_latest_path
      return unless request.format.html? && request.get?
      return if controller_name == "auth0"

      session[:bouncer_latest_path] = request.fullpath
    end
  end
end

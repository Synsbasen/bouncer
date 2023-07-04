module Bouncer
  module Authentication
    extend ActiveSupport::Concern

    included do
      helper_method "current_#{Bouncer.user_class.to_s.underscore}".to_sym
      helper_method "#{Bouncer.user_class.to_s.underscore}_signed_in?".to_sym

      after_action :store_latest_path
    end

    def sign_in(user)
      return false unless user && user.persisted?

      Bouncer::Event::SignIn.create(user: user, ip: request.remote_ip)

      session[:bouncer_user_id] = user.id
    end

    def sign_out
      Bouncer::Event::SignOut.create(user: bouncer_current_user, ip: request.remote_ip) if bouncer_current_user.present?

      reset_session
    end

    def authenticate_user!
      redirect_to "/" unless user_signed_in?
    end

    private

    define_method "current_#{Bouncer.user_class.to_s.underscore}".to_sym do
      user_id = session[:bouncer_user_id]
      eval "Current.#{Bouncer.user_class.to_s.underscore} ||= user_id && Bouncer.user_class.find_by_id(user_id)"
    end

    define_method "#{Bouncer.user_class.to_s.underscore}_signed_in?".to_sym do
      bouncer_current_user.present?
    end

    def store_latest_path
      return unless request.format.html? && request.get?
      return if controller_name == "auth0"

      session[:bouncer_latest_path] = request.fullpath
    end

    protected

    def bouncer_current_user
      send("current_#{Bouncer.user_class.to_s.underscore}")
    end
  end
end

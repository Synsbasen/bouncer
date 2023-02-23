module Bouncer
  class Auth0Controller < ApplicationController
    def callback
      # OmniAuth stores the information returned from Auth0 in request.env['omniauth.auth']
      auth_info = request.env['omniauth.auth']

      # Find or create the user
      user = find_or_initialize_from_provider_data(auth_info)

      # If the user is new, set session variable
      # We're using this to trigger the missing_fields_modal so the user can consent to marketing emails
      if user.new_record?
        session[:bouncer_new_user] = true
        user.save!
      end

      # Store the user information in the session and sign in the suer
      sign_in user

      redirect_to session[:bouncer_latest_path] || '/'
    rescue ActiveRecord::RecordInvalid => e
      flash[:error] = e.message
      redirect_to '/'
    end

    def failure
      flash[:error] = request.params['message']
      redirect_to '/'
    end

    def logout
      sign_out

      redirect_to logout_url, allow_other_host: true
    end

    def logout_callback
      redirect_to session[:bouncer_latest_path] || '/'
    end

    private

    def logout_url
      request_params = {
        returnTo: auth_logout_callback_url,
        client_id: Bouncer.auth0_client_id,
      }

      URI::HTTPS.build(host: Bouncer.auth0_domain, path: '/v2/logout', query: request_params.to_query).to_s
    end

    def find_or_initialize_from_provider_data(provider_data)
      provider = provider_data.uid.split('|').first

      Bouncer.user_class.where(uid: provider_data.uid, provider: provider).first_or_initialize do |user|
        raw_info = provider_data.extra.raw_info

        user.first_name = raw_info.given_name || ''
        user.last_name = raw_info.family_name || ''
        user.email = raw_info.email
        user.accept_toc = true
      end
    end
  end
end

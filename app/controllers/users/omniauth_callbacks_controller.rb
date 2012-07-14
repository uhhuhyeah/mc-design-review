class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticity_token
  
  def yammer
    raise auth_hash
    process_user( User.find_for_oauth(auth_hash, current_user), 'yammer')
  end

  # callback for google
  def google
    process_user( User.find_for_open_id(auth_hash, current_user), 'google')
  end

  def developer
    redirect_to root_path if Rails.env.production?
    process_user( User.find_for_developer(auth_hash, current_user), 'developer')
  end

  protected

  def auth_hash
    @auth_hash ||= request.env['omniauth.auth']
  end

  def process_user(user, provider)
   if user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => provider.titleize
      sign_in_and_redirect user, :event => :authentication
    else
      session["devise.#{provider}_data"] = auth_hash
      redirect_to new_user_registration_url
    end
  end

end


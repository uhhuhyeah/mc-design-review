class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticuty_token, :only => [:google, :yammer]

  def yammer
     @user = User.find_for_oauth(request.env['omniauth.auth'], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => 'Yammer'
      sign_in_and_redirect @user, :event => :authentication
    else
      session['devise.yammer_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
   
  end

  # callback for google
  def google
    @user = User.find_for_open_id(request.env['omniauth.auth'], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => 'Google'
      sign_in_and_redirect @user, :event => :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end


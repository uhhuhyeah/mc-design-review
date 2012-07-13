class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticity_token

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

  def developer
    redirect_to root_path if Rails.env.production?
    
    auth = request.env['omniauth.auth']

    @user = User.find_by_email(auth['uid'])

    if @user.nil?
      @user = User.create!(email: auth['uid'], name: auth['info']['name'], password: Devise.friendly_token[0,20])
    end
    
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => 'Developer'
      sign_in_and_redirect @user, :event => :authentication
    else
      session['devise.developer_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

 end


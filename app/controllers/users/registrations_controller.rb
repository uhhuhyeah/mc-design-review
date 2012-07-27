class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :go_away, :only => [:new, :create]

  def new;end
    
  def create;end

  def edit
    super
  end

  def update
    @user = User.find(current_user.id)
    if @user.update_without_password(params[:user)
      redirect_to root_path, notice: 'Profile successfully updated'
    else
      render :edit
    end
  end

  def delete
    super
  end
    
  protected 
  def go_away
    redirect_to root_path and return
  end
end

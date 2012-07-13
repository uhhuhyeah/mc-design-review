class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :go_away, :only => [:new, :create]

  def new;end
    
  def create;end

  def edit
    super
  end

  def update
    super
  end

  def delete
    super
  end
    
  protected 
  def go_away
    redirect_to root_path and return
  end
end

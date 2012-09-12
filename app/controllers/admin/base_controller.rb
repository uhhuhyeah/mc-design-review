class Admin::BaseController < ApplicationController
  before_filter :require_admin
  
  protected 
  
  def require_admin
    unless current_user && %w(d.mcclain@modcloth.com w.baily@modcloth.com).include?( current_user.email )
      redirect_to root_path, error: "You don't have permission to view this page"
    end
  end
end
class Admin::ChairsController < Admin::BaseController
  
  def index
    @chair = Chair.current
    @users = User.order('name asc')
  end
  
  def create
    chair = Chair.create(user_id: params[:user_id])
    redirect_to admin_chairs_path
  end
end
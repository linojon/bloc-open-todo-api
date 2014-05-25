class Api::ListsController < ApiController

  def index
    #return if permission_denied?
    user = User.find(params[:user_id])
    if params[:password] && user.authenticate?(params[:password])
      render json: user.lists.all
    else
      render json: user.lists.public
    end
  end

end
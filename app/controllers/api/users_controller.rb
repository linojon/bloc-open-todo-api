class Api::UsersController < ApiController

  def index
    users = User.all
    render json: users, each_serializer: UsersSerializer
  end

  def create
    user = User.new(new_user_params)
    if user.save
      render json: user, root: false, status: :created # 201
    else
      error :unprocessable_entity, user.errors.full_messages #422
    end
  end

  private

  def new_user_params
    params.permit(:username, :password)
  end

end
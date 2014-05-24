class Api::UsersController < ApiController

  def index
    return if permission_denied?
    users = User.all
    render json: users, each_serializer: UsersSerializer
  end

  def create
    return if permission_denied?
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

  def permission_denied?
    permission_denied_error unless conditions_met
  end

  def conditions_met
    true
  end

end
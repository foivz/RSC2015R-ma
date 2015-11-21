class Api::UsersController < Api::ApiBaseController
  before_action { @field_name = :user }
  before_action(only: :index) { @field_name = :users }

  before_action :set_user, only: [:show, :update, :destroy]

  skip_before_action :check_access_token, only: :create

  def index
    @users = User.filter(filtering_params)
  end

  def show
  end

  def me
    @user = logged_in_user

    render :show
  end

  def create
    permitted_params = user_params
    permitted_params.delete(:current_password)

    if User.exists?(username: permitted_params[:username])
      render_conflict 'User with provided username already exists.'
      return
    end

    @user = User.new(permitted_params)
    @user.role ||= :player # Default role
    if @user.save
      render :show, status: :created
    else
      render_save_error_for(@user)
    end
  end

  def update
    permitted_params = user_params

    # Only allow password changing if current password is provided
    current_password = permitted_params.delete(:current_password)
    if current_password.present?
      unless User.authenticate(@user.username, current_password)
        render_unprocessable_entity 'Current password is not correct.'
        return
      end
    else
      permitted_params.delete(:password)
      permitted_params.delete(:password_confirmation)
    end

    @user.assign_attributes(permitted_params)

    if @user.save
      render :show
    else
      render_save_error_for(@user)
    end
  end

  def destroy
    @user.destroy
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:name, :username, :current_password, :password, :password_confirmation, :role, :active)
  end

  def filtering_params
    params.permit(:role, :active, :query)
  end

  def set_user
    @user = User.find_by_id(params[:id])
    render_not_found('User with specified id does not exist.') if @user.blank?
  end
end

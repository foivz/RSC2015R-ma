class Api::AuthenticationController < Api::ApiBaseController
  before_action(only: :login) { @field_name = :login }
  skip_before_action :check_access_token, only: :login

  def login
    user_login(login_params)

    render_unauthorized('') if @access_token.blank?
  end

  def logout
    user_logout
  end

private
  def user_login(params)
    username = params[:username]
    password = params[:password]

    if username.present?
      username = username.downcase

      user = User.authenticate(username, password)
      return if user.blank? || user.inactive?

      @access_token = user.update_access_token
      @user = user
    end
  end

  def user_logout
    user = User.find_by_id(access_id_header)
    user.update_access_token
  end

  def login_params
    params.permit(:username, :password)
  end
end

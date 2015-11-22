class Api::UsersController < Api::ApiBaseController
  before_action { @field_name = :user }
  before_action(only: :index) { @field_name = :users }

  before_action :set_user, only: [:show, :update, :destroy, :update_location, :ready, :kill, :capture]

  skip_before_action :check_access_token, only: [:index, :create, :show]

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

  def update_location
    @user.update_attributes(latitude: params[:latitude], longitude: params[:longitude])
    render :show
  end

  def destroy
    @user.destroy
    render :show
  end

  def ready
    @user.update_attributes(ready: true)
    render :show
  end

  def kill
    @user.update_attributes(alive: false, ready: false)

    # Send killed message
    TeamMessage.create(user_id: @user.id, team_id: @user.team_id, message: killed_message)

    # Update opponent team's score
    game = Game.find_by_id(@user.game_id)
    opponent_team = game.team_a.id == @user.team_id ? game.team_b : game.team_a

    opponent_team.score += 1
    opponent_team.save

    # Insert record in statistics table
    duration_alive = ((DateTime.now - game.start_date.to_datetime) * 24 * 60 * 60).to_i
    UserStatistic.create(user_id: @user.id, game_id: game.id, died: true, duration_alive: duration_alive)

    # Is game over?
    this_team = Team.find_by_id(@user.team_id)
    if this_team.alive_count == 0
      game.playing = false
      game.won = opponent_team.name

      this_team.users.each do |player|
        statistic = UserStatistic.where(user_id: player.id, game_id: game.id).take
        statistic.won = false
        statistic.save
      end

      opponent_team.users.each do |player|
        if player.alive
          UserStatistic.create(user_id: player.id, game_id: game.id, died: false, duration_alive: duration_alive, won: true)
        else
          statistic = UserStatistic.where(user_id: player.id, game_id: game.id).take
          statistic.won = true
          statistic.save
        end
      end

      game.save
    end

    render :show
  end

  def capture
    if Obstacle.exists?(pin: params[:pin])
      game = @user.game

      this_team = @user.team
      opponent_team = game.team_a.id == @user.team_id ? game.team_b : game.team_a

      # Update team scores
      this_team.score = 1
      this_team.save

      opponent_team.score = 0
      opponent_team.save

      # Update game state
      game.playing = false
      game.won = this_team.name
      game.save

      # Update statistics
      duration_alive = ((DateTime.now - game.start_date.to_datetime) * 24 * 60 * 60).to_i
      this_team.users.each do |player|
        if player.alive
          UserStatistic.create(user_id: player.id, game_id: game.id, died: false, duration_alive: duration_alive, won: true)
        else
          statistic = UserStatistic.where(user_id: player.id, game_id: game.id).take
          statistic.won = true
          statistic.save
        end
      end

      opponent_team.users.each do |player|
        if player.alive
          UserStatistic.create(user_id: player.id, game_id: game.id, died: false, duration_alive: duration_alive, won: false)
        else
          statistic = UserStatistic.where(user_id: player.id, game_id: game.id).take
          statistic.won = false
          statistic.save
        end
      end
      render :show
    else
      render_not_found('Wrong pin')
    end
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

  def killed_message
    "#{@user.name} has been killed!"
  end
end

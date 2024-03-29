class Api::GamesController < Api::ApiBaseController
  before_action { @field_name = :game }
  before_action(only: :index) { @field_name = :games }

  before_action :set_game, only: [:show, :destroy, :ready, :start]

  skip_before_action :check_access_token, only: [:index, :show]

  def index
    @games = Game.filter(filtering_params).order(start_date: :desc)
  end

  def create
    # Teams
    count = params[:count] / 2
    # Team A
    team_a_data = params[:team_a]
    team_a = Team.create(name: 'A', count: count, latitude: team_a_data[:latitude], longitude: team_a_data[:longitude])
    # Team B
    team_b_data = params[:team_b]
    team_b = Team.create(name: 'B', count: count, latitude: team_b_data[:latitude], longitude: team_b_data[:longitude])

    # Field
    field_id = params[:field_id]
    Field.update(field_id, occupied: true)

    # Game
    game_data = params
    @game = Game.create(name: game_data[:name], field_id: game_data[:field_id], type: game_data[:type], duration: game_data[:duration] * 60,
      judge_id: @logged_in_user.id, team_a_id: team_a.id, team_b_id: team_b.id)

    # Obstacles
    obstacles_data = params[:obstacles]
    obstacles_data.each do |obstacle_data|
      Obstacle.create(game_id: @game.id, type: obstacle_data[:type],
        latitude: obstacle_data[:latitude], longitude: obstacle_data[:longitude])
    end

    # Join judge to game
    @logged_in_user.game_id = @game.id
    @logged_in_user.save

    render :show, status: :created
  end

  def show
  end

  def join
    team_char = params[:team]
    pin = params[:pin]
    @game = Game.where(pin: pin).take

    team = team_char.upcase == 'A' ? @game.team_a : @game.team_b

    player = User.find_by_id(@logged_in_user.id)
    player.update_attributes(game_id: @game.id, team_id: team.id, alive: true, ready: false)

    render :show
  end

  def ready
    @game.update_attributes(players_in: true)
    render :show
  end

  def start
    @game.update_attributes(playing: true, start_date: DateTime.now)
    render :show
  end

  def destroy
    # Release players
    @game.team_a.users.each do |player|
      player.update_attributes(game_id: nil, team_id: nil, ready: false)
    end
    @game.team_b.users.each do |player|
      player.update_attributes(game_id: nil, team_id: nil, ready: false)
    end

    # Release field
    Field.update(@game.field_id, occupied: false)

    # Delete teams
    @game.team_a.update_attributes(active: false)
    @game.team_b.update_attributes(active: false)

    @game.update_attributes(active: false, playing: false, players_in: false)
    render :show
  end

  protected
  def set_game
    @game = Game.find_by_id(params[:id])
    render_not_found('Game with specified id does not exist.') if @game.blank?
  end

  def game_params
    params.require(:game).permit(:name, :field_id, :type, :duration)
  end

  def filtering_params
    params.permit(:active, :playing)
  end
end

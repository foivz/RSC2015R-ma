class Api::GamesController < Api::ApiBaseController
  before_action { @field_name = :game }
  before_action(only: :index) { @field_name = :games }

  # skip_before_action :check_access_token

  def index
    Game.all
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

    # Game
    game_data = params
    @game = Game.create(name: game_data[:name], field_id: game_data[:field_id], type: game_data[:type], duration: game_data[:duration],
      judge_id: @logged_in_user.id, team_a_id: team_a.id, team_b_id: team_b.id)

    # Obstacles
    obstacles_data = params[:obstacles]
    obstacles_data.each do |obstacle_data|
      obstacle_data[:team].tap do |team|
        obstacle_data[:team_id] = team_a.id if team == 'A'
        obstacle_data[:team_id] = team_b.id if team == 'B'
      end

      Obstacle.create(game_id: @game.id, team_id: obstacle_data[:team_id], type: obstacle_data[:type],
        latitude: obstacle_data[:latitude], longitude: obstacle_data[:longitude])
    end

    render :show, status: :created
  end

  def join
    team_char = params[:team]
    pin = params[:pin]
    @game = Game.where(pin: pin).take

    team = team_char == 'A' ? @game.team_a : @game.team_b

    player = User.find_by_id(@logged_in_user.id)
    player.update_attributes(game_id: @game.id, team_id: team.id, alive: true, ready: false)

    render :show
  end

  def start

  end

  protected
  def game_params
    params.require(:game).permit(:name, :field_id, :type, :duration)
  end
end

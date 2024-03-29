class Api::TeamMessagesController < Api::ApiBaseController
  before_action { @field_name = :team_message }
  before_action(only: [:index, :inbox]) { @field_name = :team_messages }

  def index
  end

  def inbox
    team = params[:team].downcase
    game = @logged_in_user.game
    team_id = (team == 'a') ? game.team_a.id : game.team_b.id

    if team_id.present?
      @team_messages = TeamMessage.where(team_id: team_id)
    else
      @team_messages = TeamMessage.where(team_id: @logged_in_user.team_id)
    end

    @team_messages = @team_messages.order(:created_at)
    render :index
  end

  def create
    team_message = team_message_params
    team_message[:user_id] = @logged_in_user.id

    team = team_message[:team]
    game = @logged_in_user.game
    team_message[:team_id] = (team == 'a') ? game.team_a.id : game.team_b.id
    team_message.delete(:team)

    if team_message[:type].present?
      team_message[:message] = PREDEFINED_MESSAGES[team_message[:type].to_sym]
      team_message.delete(:type)
    end

    @team_message = TeamMessage.create(team_message)
    render :show, status: :created
  end

  def attack
    team_message = prepare_team_message(:attack)
    @team_message = TeamMessage.create(team_message)
    render :show, status: :created
  end

  def fallback
    team_message = prepare_team_message(:fallback)
    @team_message = TeamMessage.create(team_message)
    render :show, status: :created
  end

  def cover
    team_message = prepare_team_message(:cover)
    @team_message = TeamMessage.create(team_message)
    render :show, status: :created
  end

  protected
  def prepare_team_message(type)
    {
      user_id: @logged_in_user.id,
      team_id: @logged_in_user.team_id,
      message: PREDEFINED_MESSAGES[type]
    }
  end

  def team_message_params
    params.permit(:user_id, :team, :team_id, :message, :type)
  end

private
  PREDEFINED_MESSAGES = {
      attack: 'Attack!',
      fallback: 'Fallback!',
      cover: 'I need cover!'
  }
end

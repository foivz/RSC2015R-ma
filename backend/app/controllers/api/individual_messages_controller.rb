class Api::IndividualMessagesController < Api::ApiBaseController
  before_action { @field_name = :individual_message }
  before_action(only: [:index, :inbox]) { @field_name = :individual_messages }

  def index
  end

  def inbox
    this_id = @logged_in_user.id
    other_id = params[:user_id]

    @individual_messages = IndividualMessage.where('(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)',
      this_id, other_id, other_id, this_id).order(:created_at)

    render :index
  end

  def create
    individual_message = individual_message_params
    individual_message[:sender_id] = @logged_in_user.id

    @individual_message = IndividualMessage.create(individual_message_params)
    render :show, status: :created
  end

  protected
  def individual_message_params
    params.permit(:recipient_id, :message)
  end
end

class Api::FieldsController < Api::ApiBaseController
  before_action { @field_name = :field }
  before_action(only: :index) { @field_name = :fields }

  before_action :set_field, only: [:show, :update, :destroy]

  # TODO: Check token
  skip_before_action :check_access_token

  def index
    @fields = Field.filter(filtering_params)
  end

  def show
  end

  def create
    permitted_params = field_params

    @field = Field.new(permitted_params)
    if @field.save
      render :show, status: :created
    else
      render_save_error_for(@field)
    end
  end

  def update
    permitted_params = field_params

    @field.assign_attributes(permitted_params)

    if @field.save
      render :show
    else
      render_save_error_for(@field)
    end
  end

  def destroy
    @field.destroy
    render :show
  end

private
  def field_params
    params.require(:field).permit(:name, :longitude_top, :latitude_top, :longitude_bottom, :latitude_bottom, :occupied)
  end

  def filtering_params
    params.permit(:occupied)
  end

  def set_field
    @field = Field.find_by_id(params[:id])
    render_not_found('Field with specified id does not exist.') if @field.blank?
  end
end

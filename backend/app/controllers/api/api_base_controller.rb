class Api::ApiBaseController < ApplicationController
  protect_from_forgery with: :null_session

  include Renderable
  before_action { @field_name = :payload }

  include Accessible
  before_action :check_access_token

  skip_before_action :verify_authenticity_token
end

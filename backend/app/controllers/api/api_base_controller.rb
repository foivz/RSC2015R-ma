class Api::ApiBaseController < ApplicationController
  protect_from_forgery with: :null_session

  include Renderable
  before_action { @field_name = :payload }

  include Accessible
  before_action :check_access_token

  skip_before_action :verify_authenticity_token

  before_filter :disable_cors

  def disable_cors
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end

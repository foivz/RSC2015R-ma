module Accessible
  extend ActiveSupport::Concern

protected
  attr_reader :logged_in_user

private
  ACCESS_TOKEN_HTTP_HEADER = Settings.request.headers.access_token
  ACCESS_ID_HTTP_HEADER = Settings.request.headers.access_id

  attr_writer :logged_in_user

  def check_access_token
    if access_id_header.blank? || access_token_header.blank?
      render_unauthorized('Missing access token.')
      return
    end

    user = User.find_by(access_id_header)
    if user.blank? || user.inactive? || user.access_token != access_token_header
      render_unauthorized('Invalid access token provided.')
    else
      self.logged_in_user = user
    end
  end

  def access_id_header
    request.headers[ACCESS_ID_HTTP_HEADER]
  end

  def access_token_header
    request.headers[ACCESS_TOKEN_HTTP_HEADER]
  end
end
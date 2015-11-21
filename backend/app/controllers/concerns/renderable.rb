module Renderable
  extend ActiveSupport::Concern

protected
  def render_template(template, status)
    api_path = Settings.api.path

    render template: "#{api_path}/#{template}", status: status
  end

  def render_save_error_for(object)
    message = "[#{object.class}] #{object.errors.full_messages.to_sentence}"
    render_unprocessable_entity(message)
  end

  # 201
  def render_created
    render status: :created
  end

  # 400
  def render_bad_request
    render_error(:bad_request, '')
  end

  # 401
  def render_unauthorized(message)
    headers['WWW-Authenticate'] = 'xBasic realm=""'

    render_error(:unauthorized, message)
  end

  # 403
  def render_forbidden(message)
    render_error(:forbidden, message)
  end

  # 404
  def render_not_found(message)
    render_error(:not_found, message)
  end

  # 409
  def render_conflict(message)
    render_error(:conflict, message)
  end

  # 422
  def render_unprocessable_entity(message)
    render_error(:unprocessable_entity, message)
  end

  def render_error(status, message)
    api_path = Settings.api.path

    @error_text = message
    render template: "#{api_path}/errors/#{status}", status: status
  end
end

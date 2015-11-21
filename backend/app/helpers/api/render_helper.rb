module Api::RenderHelper
  def status
    {
      code:     response.status,
      text:     Rack::Utils::HTTP_STATUS_CODES[response.status],
      message:  @error_text
    }
  end

  def payload_field_name
    @field_name
  end

  def render_json_partial(json, object, options = nil)
    api_path = Settings.api.path
    object_name = object.class.model_name.singular
    folder_name = object.class.model_name.plural
    partial_path = "#{api_path}/#{folder_name}/#{object_name}"

    options = combine_options(object_name.to_sym, object, options)
    json.partial! "#{partial_path}", options
  end

private
  def combine_options(object_name, object, options)
    options = {} if options.nil?
    options[object_name] = object

    options
  end
end

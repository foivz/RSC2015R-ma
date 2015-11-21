json.array!(@individual_messages) do |individual_message|
  render_json_partial json, individual_message
end

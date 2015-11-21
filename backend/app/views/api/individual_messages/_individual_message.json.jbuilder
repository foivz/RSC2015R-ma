json.extract! individual_message, :message

json.sender do
  render_json_partial json, individual_message.sender
end

json.recipient do
  render_json_partial json, individual_message.recipient
end

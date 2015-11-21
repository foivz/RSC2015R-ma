json.extract! team_message, :message

json.sender do
  render_json_partial json, team_message.user
end

json.team do
  render_json_partial json, team_message.team
end

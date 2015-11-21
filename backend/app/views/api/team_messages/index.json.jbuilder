json.array!(@team_messages) do |team_message|
  render_json_partial json, team_message
end

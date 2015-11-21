json.array!(@users) do |user|
  render_json_partial json, user
end
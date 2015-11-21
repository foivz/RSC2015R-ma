json.array!(@games) do |game|
  render_json_partial json, game
end

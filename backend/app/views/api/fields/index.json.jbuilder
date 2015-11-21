json.array!(@fields) do |field|
  render_json_partial json, field
end

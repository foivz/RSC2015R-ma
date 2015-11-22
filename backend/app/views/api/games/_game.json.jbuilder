json.extract! game, :id, :name, :duration, :type, :pin, :start_date, :judge_id, :players_in, :playing, :created_at, :updated_at

json.total_count game.total_count
json.joined_count game.joined_count
json.alive_count game.alive_count

json.field do
  render_json_partial json, game.field
end

json.team_a do
  # json.extract! game.team_a, :id, :name, :count, :score, :latitude, :longitude
  render_json_partial json, game.team_a

  json.players do
    json.array!(game.team_a.users) do |user|
      # json.extract! user, :id, :name, :ready, :alive, :latitude, :longitude
      render_json_partial json, user
    end
  end
end

json.team_b do
  # json.extract! game.team_b, :id, :name, :count, :score, :latitude, :longitude
  render_json_partial json, game.team_b

  json.players do
    json.array!(game.team_b.users) do |user|
      # json.extract! user, :id, :name, :ready, :alive, :latitude, :longitude
      render_json_partial json, user
    end
  end
end

json.obstacles do
  json.array!(game.obstacles) do |obstacle|
    json.extract! obstacle, :latitude, :longitude, :type, :team_id
  end
end

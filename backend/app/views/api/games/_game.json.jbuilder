json.extract! game, :id, :name, :duration, :type, :pin, :start_date, :judge_id, :players_in, :playing, :created_at, :updated_at

json.total_count game.total_count
json.joined_count game.joined_count
json.alive_count game.alive_count

json.team_a do
  json.extract! game.team_a, :id, :name, :count, :score, :latitude, :longitude

  json.players do
    json.array!(game.team_a.users) do |user|
      json.extract! user, :id, :name, :ready, :alive
    end
  end
end

json.team_b do
  json.extract! game.team_b, :id, :name, :count, :score, :latitude, :longitude

  json.players do
    json.array!(game.team_b.users) do |user|
      json.extract! user, :id, :name, :ready, :alive
    end
  end
end

json.obstacles do
  json.array(game.obstacles) do |obstacle|
    json.extract! obstacle, :latitude, :longitude, :type, :team_id
  end
end

json.extract! user, :id, :name, :username, :role, :active, :game_id, :team_id, :ready, :alive, :created_at, :updated_at

json.latitude (user[:latitude] || BigDecimal.new(0))
json.longitude (user[:longitude] || BigDecimal.new(0))

if user.team.present?
  json.team user.team.name
end

if user.has_statistics
  json.statistics do
    json min_duration user.min_duration
    json max_duration user.max_duration
    json avg_duration user.avg_duration
    json death_count user.death_count
    json win_count user.win_count
    json loss_count user.loss_count
  end
end

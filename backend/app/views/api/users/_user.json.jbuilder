json.extract! user, :id, :name, :username, :role, :active, :game_id, :team_id, :ready, :alive, :created_at, :updated_at

json.latitude (user[:latitude] || BigDecimal.new(0))
json.longitude (user[:longitude] || BigDecimal.new(0))

if user.team.present?
  json.team user.team.name
end

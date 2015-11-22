json.extract! team, :id, :name, :longitude, :latitude, :score, :created_at, :updated_at

json.total_count team.total_count
json.joined_count team.joined_count
json.alive_count team.alive_count
json.dead_count team.dead_count

json.extract! team_message, :message

json.sender_name team_message.user.name
json.team_name team_message.team.name

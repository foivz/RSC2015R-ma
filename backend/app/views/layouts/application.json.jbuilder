json.status do
  status.each do |key, value|
    json.set! key, value
  end
end

payload = yield
if payload != 'null'
  json.set! payload_field_name, JSON.parse(payload)
end

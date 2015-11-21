payload = yield
if payload != 'null'
  json.set! payload_field_name, JSON.parse(payload)
end

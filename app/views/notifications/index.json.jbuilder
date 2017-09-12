json.array! @notifications do |notification|
  json.read_at notification.read_at
  json.created_at notification.created_at
end

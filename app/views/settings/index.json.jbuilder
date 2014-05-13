json.array!(@settings) do |setting|
  json.extract! setting, :id, :year, :total_leaves
  json.url setting_url(setting, format: :json)
end

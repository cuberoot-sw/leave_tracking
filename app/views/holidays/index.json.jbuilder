json.array!(@holidays) do |holiday|
  json.extract! holiday, :id, :date, :occasion
  json.url holiday_url(holiday, format: :json)
end

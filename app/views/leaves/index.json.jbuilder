json.array!(@leaves) do |leafe|
  json.extract! leafe, :id, :start_date, :end_date, :no_of_days, :status, :reason, :approved_on, :approved_by, :rejection_reason, :references
  json.url leafe_url(leafe, format: :json)
end

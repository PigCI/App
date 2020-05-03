json.array! [:max, :mean, :min] do |field|
  json.name field.to_s.titleize
  json.data ReportRowDecorator.decorate_collection(@report.data, context: { profiler: @report.object.profiler }) do |row|
    json.array! [row.key, row.send(field)]
  end
end

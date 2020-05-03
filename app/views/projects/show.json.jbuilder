json.array! Report.profilers.keys do |profiler|
  if Report.new(profiler: profiler).unit.present?
    json.name "#{Report.human_enum_name(:profiler, profiler)} (#{Report.new(profiler: profiler).unit})"
  else
    json.name "#{Report.human_enum_name(:profiler, profiler)}"
  end

  json.data @report_collections.reverse do |report_collection|
    json.array! [
      report_collection.to_s,
      report_collection.reports.max_value_for_collection_by_profiler.select { |report| report.profiler == profiler }.first&.decorate&.max,
    ]
  end
end

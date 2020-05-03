class Seeds::Report::DatabaseRequest < Seeds::Report
  def profiler
    'database_request'
  end

  private

  def max
    rand(100..150)
  end

  def variance
    49
  end
end

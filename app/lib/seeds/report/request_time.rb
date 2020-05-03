class Seeds::Report::RequestTime < Seeds::Report
  def profiler
    'request_time'
  end

  private

  def max
    rand(40..300)
  end

  def variance
    20
  end
end

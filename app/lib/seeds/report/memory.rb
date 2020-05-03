class Seeds::Report::Memory < Seeds::Report
  def profiler
    'memory'
  end

  private

  def max
    rand(175_000_000..250_000_000)
  end

  def variance
    75_000_000
  end
end

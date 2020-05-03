class ReportRowDecorator < ApplicationDecorator
  def key
    object[:key]
  end

  def max
    h.number_with_precision(BigDecimal(object[:max]) / modifier, precision: 0)
  end

  def min
    h.number_with_precision(BigDecimal(object[:min]) / modifier, precision: 0)
  end

  def mean
    h.number_with_precision(BigDecimal(object[:mean]) / modifier, precision: 0)
  end

  def number_of_requests
    object[:number_of_requests]
  end

  private

  def modifier
    @bytes_in_a_megabyte ||= context[:profiler] == 'memory' ? BigDecimal(1048576) : BigDecimal(1)
  end
end

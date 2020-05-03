class Seeds::Report
  def to_h
    {
      profiler: profiler,
      data: data
    }
  end

  def profiler
    'memory'
  end

  def data
    keys.collect do |key|
      values = {
        "key" => key,
        "max" => max - rand(variance),
        "min" => '',
        "mean" => '',
        "total" => '',
        "number_of_requests" => (rand(6) + 1)
      }

      if values['number_of_requests'] == 1
        values['min'] = values['max']
      else
        values['min'] = values['max'] - rand(variance)
      end
      values['mean'] = (values['min'] + values['max']) / 2
      values['total'] = values['mean'] * values['number_of_requests']

      values
    end
  end

  private

  def max
    250_000_000
  end

  def variance
    75_000_000
  end

  def keys
    [
      'GET Admin::AdminUsersController#index{format:html}',
      'GET Admin::AdminUsersController#edit{format:html}',
      'GET ReportsController#index{format:html}',
      'GET ReportsController#index{format:json}',
      'GET ReportsController#show{format:html}',
      'GET LandingsController#index{format:html}',
    ]
  end
end

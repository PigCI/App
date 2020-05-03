module WaitFor
  # For for what ever block is passed in to equal true, handy for when waiting for
  # an upload to complete.
  def wait_for(&block)
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until yield
    end
  end
end

RSpec.configure do |config|
  config.include WaitFor, type: :feature
end

class ApplicationForm
  include ActiveModel::Model

  def initialize(attributes)
    # Pass flag to set_attributes to allow setting attributes with private writers
    set_attributes(attributes, true)
  end

  def attributes=(attributes)
    set_attributes(attributes, true)
  end

  def save
    if valid?
      persist!
    else
      false
    end
  end

  attr_reader :context
  attr_writer :context

  private

  def persist!; end
end

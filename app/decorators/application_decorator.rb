class ApplicationDecorator < Draper::Decorator
  def created_at
    time_ago_in_words(:created_at)
  end

  def updated_at
    time_ago_in_words(:updated_at)
  end

  private

  def time_ago_in_words(field)
    h.content_tag :time, datetime: object.send(field), title: object.send(field) do
      h.time_ago_in_words(object.send(field)) + ' ago'
    end
  end

  def i18n_enum_lookup(field)
    return if object.send(field).blank?

    I18n.t("#{field}.#{object.send(field)}", scope: [:activerecord, :enums, model_name.i18n_key])
  end
end

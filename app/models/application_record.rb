class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :newest, -> { order(created_at: :desc) }
  scope :oldest, -> { order(created_at: :asc) }
  scope :freshest, -> { order(updated_at: :desc) }
  scope :stalest, -> { order(updated_at: :asc) }

  def self.human_enum_name(enum_name, enum_value)
    I18n.t("activerecord.enums.#{model_name.i18n_key}.#{enum_name.to_s.pluralize}.#{enum_value}").presence || enum_value.humanize
  end
end

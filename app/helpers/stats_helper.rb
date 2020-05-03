module StatsHelper
  def render_stat_for(object, field)
    [
      content_tag(:div, object.class.human_attribute_name(field), class: 'small text-muted"'),
      content_tag(:div, object.send(field), class: 'font-weight-bold'),
    ].join('').html_safe
  end
end

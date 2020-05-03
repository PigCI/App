module FlashesHelper
  def render_flashes
    if flash.any?
      content_tag :div, class: 'alerts' do
        flash.collect do |key, value|
          render_component 'alert', class: "alert--rails-#{key}", text: value
        end.join('').html_safe
      end
    end
  end
end

class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :performer_not_authorized

  include Croutons::Controller

  before_action :set_locale
  before_action :setup_default_meta_tags_from_i18n
  before_action :set_raven_context

  private

  def set_locale
    I18n.locale = http_accept_language.preferred_language_from(I18n.available_locales) || I18n.default_locale
  end

  def pundit_user
    current_user
  end

  def performer_not_authorized(exception)
    return redirect_to({ action: :index }, alert: t('pundit.performer_not_authorized.alert')) if exception.policy.try(:index?)

    redirect_to(root_path, alert: t('pundit.performer_not_authorized.alert'))
  end

  def setup_default_meta_tags_from_i18n
    set_meta_tags(
      site: 'PigCI',
      description: t('.description', default: '', scope: %w[meta_tags]),
      keywords: t('.keywords', default: '', scope: %w[meta_tags]),
      charset: 'utf-8',
      canonical: canonical_url,
      separator: '|',
      reverse: true
    )
  end

  def canonical_url
    url_for()
  rescue ActionController::UrlGenerationError
    nil
  end

  # https://github.com/thoughtbot/croutons/blob/master/lib/croutons/controller.rb
  # Taken from here. Let us list the breadcrumbs for the title tag.
  helper_method :breadcrumbs_from_croutons
  def breadcrumbs_from_croutons(objects = {})
    @breadcrumbs_from_croutons ||= begin
                                     template = lookup_context.find_template(@_template, @_prefixes)
                                     template_identifier = template.virtual_path.gsub('/', '_')
                                     objects.reverse_merge!(view_assigns)
                                     breadcrumb_trail.breadcrumbs(template_identifier, objects)
                                   end
  end

  def set_raven_context
    Raven.user_context(id: session['warden.user.user.key']&.first&.first)
    Raven.extra_context(params: params.to_unsafe_h, url: request.url, subdomain: request.subdomain)
  end
end

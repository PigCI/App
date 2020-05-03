class LegalsController < ApplicationController
  before_action :set_cache_headers

  def terms_of_service; end

  def privacy_policy; end

  def cookie_policy; end

  def subprocessors; end

  def github_integration_deprecation_notice; end

  private

  def set_cache_headers
    expires_in 1.month, public: true
  end
end

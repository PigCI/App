class LandingController < ApplicationController
  def index
    set_meta_tags twitter: {
      card: 'summary',
      site: '@pig_ci',
      creator: '@MikeRogers0',
      url: root_url,
      title: 'PigCI - Rails Performance Tracking via CI',
      description: "Track your apps performance metrics via your Test Suite & stop slow downs before they're deployed",
      image: {
        _: ActionController::Base.helpers.asset_url('logo_pigci.svg'),
        width: 54,
        height: 50,
        alt: "PigCI Logo - It is a pink pig."
      }
    }
  end

  def api; end

  def contact_us; end

  def roadmap; end
end

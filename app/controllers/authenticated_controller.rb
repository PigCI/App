class AuthenticatedController < ApplicationController
  before_action :authenticate_user!

  layout 'authenticated'
end

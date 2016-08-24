class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :get_device_id

  private
  def get_device_id
    @oli_device_id = request.headers["OLI-Device-ID"]
  end
end

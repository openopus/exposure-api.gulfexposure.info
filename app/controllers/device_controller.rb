# device_controller.rb: -*- Ruby -*-  DESCRIPTIVE TEXT.
# 
#  Copyright (c) 2016 Brian J. Fox
#  Author: Brian J. Fox (bfox@opuslogica.com) Tue Sep  6 14:05:36 2016.
class DeviceController < GenericApiRails::RestController
  before_action :setup
  def model
    @model ||= Device
  end

  def create
    data = JSON.parse(request.raw_post) rescue nil
    data ||= params
    data = HashWithIndifferentAccess.new(data) if data
    existing = Device.where(token: data[:token]).first
    if not existing
      super
    else
      render json: existing
    end
  end
end

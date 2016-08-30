# heatmap_controller.rb: -*- Ruby -*-  DESCRIPTIVE TEXT.
# 
#  Copyright (c) 2016 Brian J. Fox
#  Author: Brian J. Fox (bfox@opuslogica.com) Tue Aug 30 13:38:28 2016.
class HeatmapController < GenericApiRails::BaseController

  def heatmap
    @users = User.where.not(latitude: nil).where.not(longitude: nil)
    @heatmap = @users.select([:codename, :latitude, :longitude])
    render json: @heatmap
  end

end

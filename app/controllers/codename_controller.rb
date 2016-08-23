# codename_controller.rb: -*- Ruby -*-  DESCRIPTIVE TEXT.
# 
#  Copyright (c) 2016 Brian J. Fox
#  Author: Brian J. Fox (bfox@opuslogica.com) Tue Aug 23 16:20:31 2016.
class CodenameController < ApplicationController
  before_action :setup
  
  def regen
    @user.regen_codename
    render json: @user
  end

  def setup
    @codename = params[:codename]
    @user = User.where(codename: @codename).first if @codename
  end
end

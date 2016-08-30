# blog_controller.rb: -*- Ruby -*-  DESCRIPTIVE TEXT.
# 
#  Copyright (c) 2016 Brian J. Fox
#  Author: Brian J. Fox (bfox@opuslogica.com) Sat Aug 27 08:41:37 2016.
class BlogController < GenericApiRails::RestController
  before_action :setup

  def model
    @model ||= Post
  end

  def create
    @post = Post.where(title: params[:title], user: @user).first_or_create(content: params[:content])
    if params[:images]
      params[:images].each do |image|
        uri = URI::Data.new(image)
        image = @post.images.create(mime_type: "image/jpeg", image_data: uri.data)
      end
    end
    render json: @post
  end

  def update
    @post.update_attributes(@params)
    render json: @post
  end

  def add_image
    result = { error: "No such post" }
    if @post
      result = @post
    end
    render json: result
  end
  
  def setup
    @codename = params[:codename]
    @user = User.where(codename: @codename).first if @codename
    @user ||= User.where(id: params[:user_id]).first if params[:user_id]
    @post = Post.where(id: params[:id]).first if params[:id]
    @post ||= Post.where(id: params[:post_id]).first if params[:post_id]
    @params = params.permit(:id, :post_id, :title, :author, :date, :mime_type, :image_id, :author, :date)
  end
end

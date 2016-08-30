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
    result = { error: "Error creating the post" }
    result = Post.where(title: @params[:title], user: @user).first_or_create(content: @params[:content])
    render json: result
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
    @params = params.permit(:id, :post_id, :title, :image_data, :mime_type, :image_id);
  end
end

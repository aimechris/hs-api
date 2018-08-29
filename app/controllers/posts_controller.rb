class PostsController < ApplicationController
  skip_before_action :advertiser_authorize_request
  before_action :set_post, only:[:show, :update, :destroy]
  # Root Content
  def index
    @posts = Post.all
    json_response(@posts)
  end
  #search
  def search
    @posts = Post.all
    json_response(@posts)
  end
  # show
  def show
    json_response(@post)
  end
  # Create Listing
  def create
    @post = Post.create!(post_params)
    json_response(@post, :created)
  end
  # Update Listing
  def update
    @post.update(post_params)
    head :no_content
  end
  # Destroy Listing
  def destroy
    @post.destroy
    head :no_content
  end

  private

  def post_params
    params.permit(:title, :category, :subtitle, :content, :post_image, :status, :published_by, :published_at,:tags_attributes)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end

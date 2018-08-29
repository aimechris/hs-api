class TagsController < ApplicationController
  skip_before_action :advertiser_authorize_request
  before_action :set_post
  before_action :set_post_tag, only: [:show, :update, :destroy]

  # GET /posts/:post_id/tags
  def index
    json_response(@post.tags)
  end

  def show
    json_response(@tag)
  end

  def create
    @post.tags.create!(tag_params)
    json_response(@post, :created)
  end

  def update
    @tag.update(tag_params)
    head :no_content
  end

  def destroy
    @tag.destroy
    head :no_content
  end

  private

  def tag_params
    params.permit(:tag_name)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_post_tag
    @tag = @post.tags.find_by!(id: params[:id]) if @post
  end
end

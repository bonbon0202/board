class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :search_models

  SORTING_MAP = {
    1 => 'created_at DESC',
    2 => 'created_at ASC',
    3 => 'updated_at DESC',
    4 => 'updated_at ASC'
  }

  def index
    if params[:sort] 
      standard = SORTING_MAP[params[:sort].to_i]
      @posts = Post.order(standard)
    else
      @posts = Post.order('created_at DESC')
    end   

    @pagy, @posts = pagy(@posts, items: 10)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search_models
    @contents_search = Post.all
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :writer)
    end
end

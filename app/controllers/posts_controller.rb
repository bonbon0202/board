class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    sort = params[:sort] || 'created_at DESC'
    category = params[:category] || 'title'
    search_text = params[:search_text] || ''
    page = params[:page] || 1
    limit = params[:limit] || 10
  
    @posts = Post.order(sort).where(category + " LIKE ?", category == "title" ? "%#{params[:search_text]}%" : params[:search_text])
    #max_page 값 추가하기
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
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
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

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :writer)
    end
end

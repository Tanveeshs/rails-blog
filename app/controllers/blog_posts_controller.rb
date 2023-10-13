class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @blog_posts = BlogPost.all
  end

  def show
  end

  def new
    @blog_post = BlogPost.new
  end

  def edit
  end

  def destroy
    @blog_post.destroy
    redirect_to root_path
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render edit, status: :unprocessable_entity
    end
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecordError::RecordNotFound
    redirect_to root_path
  end

  def blog_post_params
    params.require(:blog_post).permit(:title, :body)
  end
end

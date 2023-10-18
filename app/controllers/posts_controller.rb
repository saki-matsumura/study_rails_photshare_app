class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
    
  def index
    @posts = Post.all.order(created_at: :desc)
  end
  
  def new
    if params[:back]
      @post = current_user.posts.build(post_params)
    else
      @post = current_user.posts.build
    end
  end

  def show
    @favorite = current_user.favorites.find_by(post_id: @post.id)
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if params[:back]
      render :new
    else
      if @post.save
        redirect_to posts_path, notice: "ブログを作成しました！"   
      else
        render :new
      end
    end
  end
  
  def confirm
    @post = current_user.posts.build(post_params)
    render :new if @post.invalid?
  end
  
  def edit
    if @post.user == current_user
      render "edit"
    else
      redirect_to posts_path, notice: "勝手に書き換えようとしないでくださ〜い！"
    end
  end
  
  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "ブログを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    if @post.user == current_user
      @post.destroy
      redirect_to posts_path, notice: "ブログを削除しました！"
    else
      redirect_to posts_path, notice: "勝手に削除しようとしないでくださ〜い！"
    end
  end

  private 
  
  def post_params
    params.require(:post).permit(:title, :content, :image, :image_cache)
  end
  
  def set_post
    @post = Post.find(params[:id])
  end

end
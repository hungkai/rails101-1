class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_post, only: [:edit, :update, :destroy]
  before_action :find_group, only: [:new, :create]
  before_action :member_required, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user
    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to account_posts_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to account_posts_path, alert: "Post deleted"
  end

  private

  def member_required
    if !current_user.is_member_of?(@group)
      redirect_to group_path(@group)
      flash[:warning] = "你不是這個討論版的成員，不能發文！"
    end
  end

  def find_post
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
  end

  def find_group
    @group = Group.find(params[:group_id])
  end

  def post_params
    params.require(:post).permit(:content)
  end

end

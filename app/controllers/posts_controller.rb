class PostsController < ApplicationController
  def index
    @post = Post.new
    if params[:search] == nil
      @posts= Post.all.order(id: "DESC")
    elsif params[:search] == ''
      @posts= Post.all.order(id: "DESC")
    else
      @posts = Post.where("content LIKE ? ",'%' + params[:search] + '%').order(id: "DESC")
    end
  end

  def show
    if Post.find_by(id: params[:id])
      @post = Post.find(params[:id])
      @like = Like.new
      @comments = @post.comments
      @comment = @post.comments.build
    else
      @posts = Post.all.order(id: "DESC")
      redirect_to :action => "index"
    end
  end
  


  def images
    if params[:search] == nil
      @posts= Post.all.order(id: "DESC")
    elsif params[:search] == ''
      @posts= Post.all.order(id: "DESC")
    else
      @posts = Post.where("content LIKE ? ",'%' + params[:search] + '%').order(id: "DESC")
    end
  end

  def create
    @post = Post.new(post_params)

    @post.user_id = current_user.id

    if @post.save
      redirect_to :action => "index"
    else
      @posts = Post.all.order(id: "DESC")
      render :action => "index"
    end
  end

  def destroy
    post = Post.find(params[:id])
    if current_user.id == post.user_id
      post.destroy
      redirect_to action: :index
    else
      redirect_to action: :index
    end
  end


  private
  def post_params
    params.require(:post).permit(:content,:image)
  end
  
end
class PostsController < ApplicationController

    before_action :authenticate_user!

    def index
        @posts = Post.limit(10).order('created_at DESC')
    end

    def show 
        @post = Post.find(params[:id])
    end

    def new
        @post = Post.new
        @post.photos.build
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.photos.present?
            @post.save
            redirect_to root_path
            flash[:notice] = "投稿が保存されました！"
        else
            redirect_to root_path
            flash[:alert] = "投稿に失敗しました"
        end
    end

    def destroy
        @post = Post.find(params[:id])
        if @post.user == current_user
          flash[:notice] = "投稿が削除されました" if @post.destroy
        else
          flash[:alert] = "投稿の削除に失敗しました"
        end
        redirect_to root_path
    end


    private
        def post_params
            params.require(:post).permit(:caption, photos_attributes:[:image])
        end

end

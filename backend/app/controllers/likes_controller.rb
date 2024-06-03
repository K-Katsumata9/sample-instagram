class LikesController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @like = current_user.likes.build(like_params)
      @post = @like.post
      if @like.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to @post }
        end
      end
    end
  
    def destroy
      @like = Like.find(params[:id])
      @post = @like.post
      if @like.destroy
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to @post }
        end
      end
    end
  
    private
  
    def like_params
      params.permit(:post_id)
    end
  end
  
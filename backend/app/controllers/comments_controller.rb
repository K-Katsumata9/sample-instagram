class CommentsController < ApplicationController
    before_action :authenticate_user!


    def create
      @comment = Comment.new(comment_params)
      @post = @comment.post
      if @comment.save
        respond_to do |format|
            format.turbo_stream
            format.js 
        end
      else
        flash[:alert] = "コメントに失敗しました"
      end
    end
    
    def destroy
        @comment = Comment.find(params[:id])
        @post = @comment.post
        if @comment.destroy
            respond_to do |format|
                format.turbo_stream
                format.js
            end
        else
          flash[:alert] = "コメントの削除に失敗しました"
        end
    end


    private
      def comment_params
        params.required(:comment).permit(:user_id, :post_id, :comment)
      end

  end
  
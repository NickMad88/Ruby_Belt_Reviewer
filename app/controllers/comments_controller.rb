class CommentsController < ApplicationController
  
  def create
    @event = Event.find(params[:id])
    @comment = Comment.new(content: comment_helper[:comment], user: current_user, event: @event)
    if @comment.save
      redirect_to event_path(params[:id])
    else
      flash[:errors] = @comment.errros.full_messages
      redirect_to event_path(params[:id])
    end
  end

  private
  def comment_helper
      params.require(:cmt).permit(:comment) if params[:cmt].present?
  end
end

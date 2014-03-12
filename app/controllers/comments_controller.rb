class CommentsController < ApplicationController
  
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
     @comment = Comment.new(comment_params)
     @blog = Blog.find(params[:blog_id])
     @blog.comments << @comment
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @blog, notice: 'comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def comment_params
    params.require(:comment).permit(:author, :body)
  end

end

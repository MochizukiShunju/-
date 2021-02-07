class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    if @comment.save

    else
      @books = Book.new
      @user = @book.user
      @book_comment = BookComment.new
      render 'books/show'
    end
  end

  def destroy
    @book_comment = BookComment.find_by(params[:book_id])
    @book = @book_comment.book
    @book_comment.destroy
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end

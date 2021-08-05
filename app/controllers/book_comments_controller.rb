class BookCommentsController < ApplicationController
  def create
    @show_book = Book.find(params[:book_id])
    
    @book_comment = BookComment.new(book_comment_params)
    @book_comment.book_id = @show_book.id
    @book_comment.user_id = current_user.id
    @book_comment.save!
    #非同期前は redirect_back(fallback_location:root_path)
  end
  def destroy
    # BookComment.find_by(id:params[:id],book_id:params[:book_id]).destroy
    # 上のコードと下のコードは同じ
    @show_book = Book.find(params[:book_id])
    @book_comment = @show_book.book_comments.find(params[:id])
    @book_comment.destroy
    # 非同期前redirect_back(fallback_location:root_path)
  end


  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end

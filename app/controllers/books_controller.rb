class BooksController < ApplicationController

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def show
    @show_book = Book.find(params[:id])
    @book = Book.new
    @users = User.all
  end

  def edit
    @show_book = Book.find(params[:id])
    if  @show_book.user ==current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def update
    @show_book = Book.find(params[:id])
    if @show_book.update(book_params)
      redirect_to book_path(@show_book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end



  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

end

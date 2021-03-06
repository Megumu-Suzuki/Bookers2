class BooksController < ApplicationController

  def index
    @book = Book.new
    #一週間でいいねの多い順で投稿を表示
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
      sort {|a,b|
        b.favorited_users.includes(:favorites).where(created_at: from...to).size <=>
        a.favorited_users.includes(:favorites).where(created_at: from...to).size
      }
    # {|a,b|a.to_i <=> b.to_i}だと昇順になる
    #今回で言うといいねの少ない順
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: 'You have created user successfully.'
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.new
    @book = Book.find(params[:id])
    impressionist(@book)
    @user = @book.user
    @book_comment = BookComment.new

  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
        render :edit
    else
        redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'You have updateed user successfully.'
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

end
class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:top]
   before_action :configure_permitted_parameters, if: :devise_controller?
  def new
  end

  def create
   @book = Book.new(book_params)
   @book.user_id = current_user.id
   if @book.save
   redirect_to book_path(@book.id)
   flash[:notice] =  'You have created book successfully.'
   else
     render :index
   end
  end
  
  def update
  user_id = Book.find(params[:id]).user.id.to_i
  login_user_id = current_user.id
  if(user_id != login_user_id)
    redirect_to books_path
  end 
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'You have updated book successfully.'
    redirect_to book_path(@book.id)
    else
    @books = Book.all
    render :edit
     
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end
 
  def show
     @book = Book.find(params[:id])
     @user = @book.user
  end

  def edit
  user_id = Book.find(params[:id]).user.id.to_i
  login_user_id = current_user.id
  if(user_id != login_user_id)
    redirect_to books_path
  end 
    @book = Book.find(params[:id])
  end

  def index
    @books = Book.all
    @book = Book.new
  end
  
   private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end

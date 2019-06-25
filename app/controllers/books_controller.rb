class BooksController < ApplicationController

	before_action :authenticate_user!
	before_action :check, only: [:update, :edit]


	def edit
		@book = Book.find(params[:id])
	end

	def index
		@books = Book.all
		@book = Book.new
	end

	def show
		@book = Book.find(params[:id])
		@booku = Book.new
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			flash[:notice] = " You have creatad book successfully."
		    redirect_to book_path(@book)
	    else
	    	@books = Book.all
		   	render :index
	    end
    end


	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		flash[:notice] = "successfully."
		redirect_to books_path
	end


	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			flash[:notice] = " You have creatad book successfully."
		redirect_to book_path(@book.id)
		else
		render :edit

		end
	end


	private
	def book_params
		params.require(:book).permit(:title, :body, :user_id)
	end
	def check
		book = Book.find(params[:id])
		if current_user != book.user
			redirect_to books_path
		end
	end

	end



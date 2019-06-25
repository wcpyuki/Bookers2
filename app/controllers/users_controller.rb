class UsersController < ApplicationController

	before_action :authenticate_user!
	before_action :check, only: [:update, :edit]

	def index
		@users = User.all
		@book = Book.new
	end

	def show
		@user = User.find(params[:id])
		@book =Book.new
		@books = Book.where(user_id: @user.id)
	end

	def new
	end

	def edit
        @user = User.find(params[:id])
    end

	def create
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = " You have creatad book successfully."
		redirect_to user_path(@user.id)
		else render :edit
	end
	end


	private
	def user_params
		params.require(:user).permit(:name, :profile_image, :introduction)
	end

	def check
		user = User.find(params[:id])
		if current_user != user
			redirect_to user_path(current_user)
		end
	end
end

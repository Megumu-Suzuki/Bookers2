class UsersController < ApplicationController


	def index
    @users = User.all
    @book = Book.new
	end

	def show
		@user = User.find(params[:id])
		# DM機能
		@currentUserEntry = Entry.where(user_id: current_user.id)
		@userEntry = Entry.where(user_id: @user.id)
		unless @user.id == current_user.id
			# 自分と他ユーザーの持つルームIDをそれぞれ比べる
			@currentUserEntry.each do |cu|
				@userEntry.each do |u|
					# 同じIDを持っていた時
					if cu.room_id == u.room_id
						# if ~ true => elseの状況を作るための定義
						@isRoom = true
						# 同じIDをIDとしてページ遷移するときに使う
						@roomID = cu.room_id
					end
				end
			end
			# 同じIDを持ってなかったら
			# 意味はわかる
			unless @isRoom # = trueってこと？
				@room = Room.new
				@entry = Entry.new
			end
		end

		@book = Book.new
		@books = @user.books
	end

	def edit
		@user = User.find(params[:id])
		if @user == current_user
    	render "edit"
		else
      redirect_to user_path(current_user.id)
		end
	endl

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to user_path(@user.id), notice: 'You have updated user successfully.'
		else
			render :edit
		end
	end

	def favorite
		@user = User.find_by(id: params[:id])
  	@favorites = Favorite.where(user_id: @user.id)
	end


	private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
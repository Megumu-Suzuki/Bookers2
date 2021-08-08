class FavoritesController < ApplicationController

    def create
        @book = Book.find(params[:book_id])
        favorite = current_user.favorites.build(book_id: @book.id)
        # @user = favorite.user
        # この定義だといいねした人＝他人のページでも数値が増える
        favorite.save
    end

    def destroy
        @book = Book.find(params[:book_id])
        favorite = current_user.favorites.find_by(book_id: @book.id)
        # @user = favorite.user
        favorite.destroy
    end



end

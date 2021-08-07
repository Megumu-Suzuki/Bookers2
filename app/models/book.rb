class Book < ApplicationRecord

    validates :title, presence: true
    validates :body, presence: true, length: { maximum: 200 }

	belongs_to :user
	has_many :book_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy

    def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end
    #すでにお気に入りされているかどうかを判定
    #user_id: user.id user_idという箱に user.idが入っていると解釈
    #user.idには@user.id,current_user.idとかが入って使われる
end

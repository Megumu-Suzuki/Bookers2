class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  attachment :profile_image
  # アソシエーション（関連づけ）
  has_many :books, dependent: :destroy
  # コメント機能
  has_many :book_comments, dependent: :destroy
  # いいね機能
  has_many :favorites, dependent: :destroy
  has_many :favorite_books, through: :favorites, source: :book
  # フォロー機能
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  # DM機能
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  
  def follow(user_id)
    active_relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    active_relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following.include?(user)
  end
end

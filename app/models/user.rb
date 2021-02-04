class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image, destroy: false

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower

  def follow(user_id)
    self.follower.create(followed_id: user_id)
  end


  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end


  def following?(user)
    following_user.include?(user)
  end

  def self.search(method,word)
    if method == "forward_match"
       @users = Post.where("text LIKE?","#{word}%")
    elsif method == "backward_match"
       @users = Post.where("text LIKE?","%#{word}")
    elsif method == "perfect_match"
        @users = Post.where("#{word}")
    elsif method == "partial_match"
        @users = Post.where("text LIKE?","%#{word}%")
    else
        @users = Post.all
    end
  end

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
end

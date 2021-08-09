class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy
  attachment :profile_image, destroy: false


  #relationshipsテーブルのfollowerカラムのどれかのidを指定する
  # User.find(4).relationshipsだとすると、followerカラムにあるid=4の方がいるレコードが参照される
  has_many :relationships,class_name:'Relationship',foreign_key:'follower_id',dependent: :destroy
  # 一行目に指定したfollowerがフォローしている人を参照
  # →この二行でfollower→followed間の関係を記述している
  has_many :followings,through: :relationships,source: :followed
  has_many :reverse_of_relationships,class_name:'Relationship',foreign_key:'followed_id',dependent: :destroy
  has_many :followers,through: :reverse_of_relationships,source: :follower

  has_many :user_rooms
  has_many :chats

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(followed_id:other_user.id)
    end
  end
  def unfollow(other_user)
    relationship=self.relationships.find_by(followed_id:other_user.id)
    relationship.destroy if relationship
  end
  def following?(other_user)
    self.followings.include?(other_user)
  end

  validates :name, length: { in: 2..20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}
end

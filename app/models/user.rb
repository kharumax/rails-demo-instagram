class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name,presence: true,length: {maximum: 50}

  has_many :likes,dependent: :destroy
  has_many :posts,dependent: :destroy
  has_many :comments,dependent: :destroy
  # フォローの関係（Relationshipモデルのfollower_idを外部キーに、中間テーブルと繋げる）
  has_many :active_relationships,class_name: "Relationship",
           foreign_key: "follower_id",dependent: :destroy
  # 中間テーブルを通して、Relationshipsモデルのfollower_idが自分のID（self.id)のRelationshipモデルを作成
  has_many :following,through: :active_relationships,source: :followed

  # フォロワーの関係
  has_many :passive_ralationships,class_name: "Relationship",
           foreign_key: "followed_id",dependent: :destroy
  has_many :followers,through: :passive_ralationships,source: :follower


  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end


  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

end

class Post < ApplicationRecord

  has_many :photos,dependent: :destroy
  has_many :comments,dependent: :destroy
  belongs_to :user
  has_many :likes,-> { order(created_at: :desc ) },dependent: :destroy

  accepts_nested_attributes_for :photos
  # 親子関係のモデルで親から子を作成、保存する際に必要
  # Postモデルの子のPhotoモデルを通して、Photoテーブルにデータを保存するため

  def liked_by(user)
    Like.find_by(user_id: user.id,post_id: id)
  end

end

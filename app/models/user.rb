class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :users
  has_many :posts, dependent: :destroy
  
  #お気に入り用
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post

  has_many :comments, dependent: :destroy
  
  mount_uploader :profile_image, ImageUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:twitter, :google_oauth2]
  
  def update_without_current_password(params, *options)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end
  
  validates :username, presence: true 
  validates :profile, length: { maximum: 200 } 

  # Twitter&Google認証ログイン用
  # ユーザーの情報があれば探し、無ければ作成する
  def self.from_omniauth(auth)
    user = User.find_by(uid: auth.uid, provider: auth.provider)

    user ||= User.create!(
      uid: auth.uid,
      provider: auth.provider,
      username: auth[:info][:name],
      #email: auth[:info][:email],
      email: User.dummy_email(auth),
      password: Devise.friendly_token[0, 20]
    )
    user
  end

  #ダミーのメールアドレスを作成
  def self.dummy_email(auth)
    "#{Time.now.strftime('%Y%m%d%H%M%S').to_i}-#{auth.uid}-#{auth.provider}@example.com"
  end
end

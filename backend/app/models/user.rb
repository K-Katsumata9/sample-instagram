class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: 50}

  has_many :posts, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    def update_without_current_password(params, *options)
      if params[:password].blank? && params[:password_confirmation].blank?
        params.delete(:password)
        params.delete(:password_confirmation)
      end

      result = update(params, *options)
      clean_up_passwords
      result
    end

end

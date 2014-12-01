class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis, dependent: :destroy
  after_initialize :set_default_for_role
  mount_uploader :avatar, AvatarUploader

  def admin?
    self.role == 'admin'
  end

  def premium?
    self.role == 'premium'
  end

  def standard?
    sef.role == 'standard'
  end

  def set_default_for_role
    self.role ||= "standard"
  end
end

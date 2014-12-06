class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis, dependent: :destroy
  has_many :collaborations
  has_many :shared_wikis, through: :collaborations

  after_initialize :set_default_for_role
  mount_uploader :avatar, AvatarUploader

  scope :all_except_admin_and_current_user, -> (user) { where("role != ?", "admin").where("id != ?", user.id) }

  def admin?
    self.role == 'admin'
  end

  def premium?
    self.role == 'premium'
  end

  def standard?
    self.role == 'standard'
  end

  def self.available_collaborators(wiki, current_user)
    User.all_except_admin_and_current_user(current_user) - wiki.collaborators
  end

  private
  
  def set_default_for_role
    self.role ||= "standard"
  end
end

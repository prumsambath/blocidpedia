class Wiki < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :user
  has_many :collaborations
  has_many :collaborators, through: :collaborations

  validates :title, presence: true, length: { minimum: 10 }
  validates :body, presence: true

  scope :public_wikis, -> { where(private: false).order("created_at DESC") }
  scope :own_wikis, -> (user) { where("user_id = ?", user.id) }
  scope :shared_to, -> (user) { joins(:collaborations).where("collaborations.user_id = ?", user.id) }

  def markdown_body
    markdown body
  end
end

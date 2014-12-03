class Wiki < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :user

  scope :public_wikis, -> { where(private: false).order("created_at DESC") }
  scope :own_wikis, -> (user) { where("user_id = ?", user.id) }

  def markdown_body
    markdown body
  end
end

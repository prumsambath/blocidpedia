class Wiki < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :user

  scope :public_wikis, -> { where(private: false).order("title ASC") }
  scope :own_wikis, -> (user) { where("user_id = ?", user.id) }

  def markdown_body
    markdown body
  end
end

class Wiki < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :user

  def markdown_body
    markdown body
  end
end

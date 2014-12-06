class Collaboration < ActiveRecord::Base
  belongs_to :shared_wiki, class_name: 'Wiki', foreign_key: 'wiki_id'
  belongs_to :collaborator, class_name: 'User', foreign_key: 'user_id'

  def self.collaboration_id(wiki, user)
    where("wiki_id = ? and user_id = ?", wiki.id, user.id).first.id
  end
end
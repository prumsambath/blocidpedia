require 'rails_helper'

RSpec.describe Wiki, :type => :model do
  it { should validate_presence_of :title }
  it { should ensure_length_of(:title).is_at_least(10) }
  it { should validate_presence_of :body }
  it { should belong_to :user }
end

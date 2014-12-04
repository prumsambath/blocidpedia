require 'rails_helper'

describe 'Welcome page' do
  it 'shows the welcome page' do
    visit root_path
    
    expect(page).to have_content('Blocidpedia: Social, Markdown Wikis')  
  end
end

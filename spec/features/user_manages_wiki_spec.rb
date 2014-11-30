require 'rails_helper'

feature 'User manages wikis' do
  scenario 'User creates a wiki' do
    standard_user = create(:standard_user)
    sign_in standard_user
    visit wikis_path
    binding.pry
    click_link 'New wiki'
    fill_in 'wiki_title', with: 'New Wiki'
    fill_in 'wiki_body', with: 'A new wiki with markdown'
    click_button 'Save wiki'
    expect(current_path).to eq(wikis_path)
    expect(path).to have_content('New wiki successfully created.')
  end
end

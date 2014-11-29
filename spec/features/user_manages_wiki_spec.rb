require 'rails_helper'

feature 'User manages wikis' do
  given(:user) { create(:user) }

  scenario 'User creates a wiki' do
    sign_in user
    visit new_wiki_path
    fill_in find_by_id('wiki_title'), with: 'New Wiki'
    fill_in find_by_id('wiki_body'), with: 'A new wiki with markdown'
    click_button 'Save wiki'
    expect(current_path).to eq(wikis_path)
    expect(path).to have_content('New wiki successfully created.')
  end
end

require 'rails_helper'

feature 'User manages wikis' do
  scenario 'Guest access to wiki' do
    visit wikis_path

    expect(page).to_not have_content('New wiki')
  end

  scenario 'Stanard creates a wiki' do
    standard_user = create(:standard_user)
    sign_in standard_user

    visit wikis_path
    click_link 'New wiki'

    expect(page).to_not have_field('Private wiki')

    fill_in 'wiki_title', with: 'My new awesome wiki'
    fill_in 'wiki_body', with: 'A new wiki with markdown'
    click_button 'Save wiki'

    expect(current_path).to eq(wikis_path)
    expect(page).to have_content('Wiki successfuly created.')
  end

  scenario 'Premium user creates a private wiki' do
    premium_user = create(:premium_user)
    sign_in premium_user

    visit wikis_path
    click_link 'New wiki'

    fill_in 'wiki_title', with: 'My new awesome wiki'
    fill_in 'wiki_body', with: 'A new wiki with markdown'
    check 'wiki_private'
    click_button 'Save wiki'
    
    expect(current_path).to eq(wikis_path)
    expect(page).to have_content('Wiki successfuly created.')
  end
end

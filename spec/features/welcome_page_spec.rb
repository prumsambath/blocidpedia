require 'rails_helper'

describe 'Welcome page' do
  it 'shows the welcome page' do
    visit root_path
    click_link 'Sign Up'
    expect(page).to have_content('Welcome to Blocidpedia')
  end
end

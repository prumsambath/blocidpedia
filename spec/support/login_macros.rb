module LoginMacros
  def set_user_session(user)
    session[:user_id] = user.id
  end
  
  def sign_in(user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email address', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end
end

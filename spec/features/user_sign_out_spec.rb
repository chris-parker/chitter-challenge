feature 'User signs out' do

  before(:each) do
    User.create(username: 'chris',
                email: 'chris@gmail.com',
                password: 'notmypassword',
                password_confirmation: 'notmypassword')
  end

  scenario 'active user signs out' do
    sign_in(username: 'chris', password: 'notmypassword')
    click_button 'Sign out'
    expect(page).to have_content('Signed out!')
    expect(page).not_to have_content('chris')
  end

  def sign_in(username:, password:)
    visit '/sessions/new'
    fill_in :username, with: username
    fill_in :password, with: password
    click_button 'Sign in'
  end

end

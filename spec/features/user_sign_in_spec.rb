feature 'User signs in' do

  let(:user) do
    User.create(username: 'chris', email: 'chris@gmail.com',
                password: 'notmypassword',
                password_confirmation: 'notmypassword')
  end

  scenario 'correct sign in' do
    sign_in(username: user.username, password: user.password)
    expect(page).to have_content "#{user.username}"
  end

  def sign_in(username:, password:)
    visit '/sessions/new'
    fill_in :username, with: username
    fill_in :password, with: password
    click_button 'Sign in'
  end

end

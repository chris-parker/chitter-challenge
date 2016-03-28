require './app/models/user'

describe User do

  let!(:user) do
    User.create(username: 'chris', email: 'chris@gmail.com',
                password: 'notmypassword',
                password_confirmation: 'notmypassword')
  end

  it 'signs in with correct username and password' do
    authenticated_user = User.authenticate(user.username, user.password)
    expect(authenticated_user).to eq user
  end

end

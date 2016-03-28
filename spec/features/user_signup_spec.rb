feature 'new user sign-up' do
  scenario 'allows a new user to sign up' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content "Chris"
    expect(User.first.email).to eq "chris@gmail.com"
  end
end

feature 'new user no sign-up' do
  scenario 'does not create a new user' do
    expect { incorrect_password_sign_up }.not_to change(User, :count)
    expect(current_path).to eq '/new/user'
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario 'cannot sign-up with blank email' do
    expect { no_email_sign_up }.not_to change(User, :count)
    expect(current_path).to eq '/new/user'
    expect(page).to have_content 'Email must not be blank'
  end

  scenario 'cannot sign-up with non-unique email' do
    sign_up
    expect { repeat_email_sign_up }.not_to change(User, :count)
    expect(current_path).to eq '/new/user'
    expect(page).to have_content 'Email is already taken'
  end

  scenario 'cannot sign-up with non-unique username' do
    sign_up
    expect { repeat_username_sign_up }.not_to change(User, :count)
    expect(current_path).to eq '/new/user'
    expect(page).to have_content 'Username is already taken'
  end
end

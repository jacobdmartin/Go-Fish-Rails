require "rails_helper"

RSpec.describe 'Sign Up', type: :system do
  it 'allows a new user to sign up' do
    visit '/'
    expect {
      fill_in 'Name', with: 'Caleb'
      fill_in 'Password', with: "evenIfUd0n't"
      fill_in 'Password confirmation', with: "evenIfUd0n't"
      click_on 'Sign Up'
    }.to change(User, :count).by(1)
    expect(page).to have_content 'Pending Games'
  end
end

RSpec.describe 'Log In', type: :system do
  it 'allows an existing user to login' do
    existing_user = create(:user, name: 'Caleb', password: "evenIfUd0n't")
    visit root_path
    click_on 'Sign In'
    expect {
      fill_in 'Name', with: 'Caleb'
      fill_in 'Password', with: "evenIfUd0n't"
      click_on 'Log in'
    }.to_not change(User, :count)
    expect(page).to have_content('Pending Games')
  end

  it 'prevents login for blank name' do
    visit '/'
    click_on 'Sign Up'
    expect(page).to have_content 'error'
  end
end

RSpec.describe 'Create Game', type: :system do
  # it 'expects the page to change when the user clicks the create game button' do
  #   visit '/'
  #   fill_in 'Name', with: 'Caleb'
  #   fill_in 'Password', with: "evenIfUd0n't"
  #   click_on 'Sign Up'
  #   click_on 'Create Game'
  #   expect(page).to have_css('new_game')
  # end
end
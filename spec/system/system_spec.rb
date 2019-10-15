require "rails_helper"

RSpec.describe 'Sign Up', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'allows a new user to sign up' do
    visit '/'
    expect {
      fill_in 'Name', with: 'Caleb'
      fill_in 'Password', with: "evenIfUd0n't"
      click_on 'Sign Up'
    }.to change(User, :count).by(1)
    expect(page.body).to have_content 'Pending Games'
  end

  it 'allows an existing user to login' do
    existing_user = create(:user, name: 'Caleb', password: "evenIfUd0n't")
    visit '/'
    expect {
      fill_in 'Name', with: 'Caleb'
      fill_in 'Password', with: "evenIfUd0n't"
      click_on 'Sign Up'
    }.to_not change(User, :count)
    expect(page.body).to have_content('Pending Games')
  end

  it 'prevents login for blank name' do
    visit '/'
    click_on 'Sign Up'
    expect(page).to have_content 'error'
  end
end
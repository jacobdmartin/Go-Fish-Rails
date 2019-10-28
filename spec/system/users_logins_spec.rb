require 'rails_helper'

RSpec.describe "UsersLogins", type: :system do
  let(:jake) { User.create(name: "Jake", password: "password", password_confirmation: "password")}

  describe "GET /users_logins" do
    it "login with invalid information" do
      visit login_path
      fill_in 'Name', with: ""
      fill_in 'Password', with: ""
      click_on 'Log in'
      expect(page).to have_current_path(login_path)
    end
  end

  describe "GET /users_logins", chrome: true do
    it "login with valid information" do
      visit login_path
      fill_in 'Name', with: jake.name
      fill_in 'Password', with: jake.password
      click_on 'Log in'
      expect(page).to have_current_path(games_path)
    end
  end

  describe 'Authentication' do
    it 'expects the session to be redirected to the login page because it does not have authorization' do
      visit games_path
      expect(page).to have_current_path(login_url, url: true)
    end
  end
end

require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  describe "GET /users_logins" do
    it "login with invalid information" do
      visit login_path
      assert_template 'sessions/new'
      post login_path, params: { session: { email: "", password: "" } }
      assert_template 'sessions/new'
      assert_not flash.empty?
      get root_path
      assert flash.empty?
    end

    it "login with invalid information" do
      visit login_path
      fill_in 'Name', with: ""
      fill_in 'Password', with: ""
      click_on 'Sign Up'
    end
  end
end

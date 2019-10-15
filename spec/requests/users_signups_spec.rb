require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do
  describe "GET /users_signups" do

    it 'returns an error because of invalid information' do
      visit '/'
      expect {
        fill_in 'Name', with: ''
        fill_in 'Password', with: 'evenIfUd0nt'
        click_on 'Sign Up'
      }.not_to change(User, :count)
      # redirect 'users/new'
      # assert_select 'div#<CSS id for error explanation>'
      # assert_select 'div.<CSS class for field with error>'
    end

    it "valid signup information" do
      visit '/'
      expect {
        fill_in 'Name', with: 'Example User'
        fill_in 'Password', with: 'user@example.com'
        click_on 'Sign Up'
      }.to change(User, :count).by(1)
      # follow_redirect!
      # assert_template 'users/show'
      assert is_logged_in?
    end
  end
end

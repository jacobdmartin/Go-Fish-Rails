require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do
  describe "GET /users_signups" do
    it "works! (now write some real specs)" do
      get users_signups_path
      expect(response).to have_http_status(200)
    end

    it "invalid signup information" do
      get signup_path
      assert_no_difference 'User.count' do
        post users_path, params: { 
          user: { 
            name:  "",
            email: "user@invalid",
            password:              "foo",
            password_confirmation: "bar" 
          } 
        }
      end
      redirect 'users/new'
      assert_select 'div#<CSS id for error explanation>'
      assert_select 'div.<CSS class for field with error>'
    end

    test "valid signup information" do
      get signup_path
      assert_difference 'User.count', 1 do
        post users_path, params: { 
          user: { 
            name:  "Example User",
            email: "user@example.com",
            password:              "password",
            password_confirmation: "password" 
          } 
        }
      end
      follow_redirect!
      assert_template 'users/show'
    end
  end
end

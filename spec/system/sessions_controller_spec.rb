require 'rails_helper'

RSpec.describe SessionsController, type: :system do

  describe "GET #new" do
    it "should get new" do
      visit :login
      expect(page).to have_http_status(:success)
    end
  end

end

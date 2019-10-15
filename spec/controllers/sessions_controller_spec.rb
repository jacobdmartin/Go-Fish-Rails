require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "should get new" do
      visit :login
      expect(response).to have_http_status(:success)
    end
  end

end

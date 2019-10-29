require "rails_helper"

RSpec.describe 'System', type: :system do

  let(:user_fred) { create(:user, name: 'Fred', password: 'examplepassword')}
  let(:user_bill) { create(:user, name: 'Bill', password: 'examplepassword', password_confirmation: 'examplepassword')}

  before :each do
    session = Capybara::Session.new(:selenium_chrome_headless, app) 
    visit root_path
  end

  describe 'Sign Up', type: :system do
    it 'allows a new user to sign up' do
      expect {
        fill_in 'Name', with: 'Caleb'
        fill_in 'Password', with: "evenIfUd0n't"
        fill_in 'Password confirmation', with: "evenIfUd0n't"
        click_on 'Sign Up'
      }.to change(User, :count).by(1)
      expect(page).to have_content 'Pending Games'
    end
  end

  describe 'Log In', type: :system do
    it 'allows an existing user to login' do
      existing_user = create(:user, name: 'Caleb', password: "evenIfUd0n't")
      click_on 'Sign In'
      expect {
        fill_in 'Name', with: 'Caleb'
        fill_in 'Password', with: "evenIfUd0n't"
        click_on 'Log In'
      }.to_not change(User, :count)
      expect(page).to have_content('Pending Games')
    end

    it 'prevents login for blank name' do
      click_on 'Sign Up'
      expect(page).to have_content 'Invalid Input'
    end
  end

  describe 'Create Game', type: :system do
    it 'expects the page to change when the user clicks the create game button' do
      fill_in 'Name', with: 'Caleb'
      fill_in 'Password', with: "examplepassword"
      fill_in 'Password confirmation', with: "examplepassword"
      click_on 'Sign Up'
      click_on 'Create Game'
      expect(page).to have_content('Name')
    end
  end

  describe 'Join Game', type: :system do
    it 'expects the page to change when the user clicks the join game button' do
      fill_in 'Name', with: 'Caleb'
      fill_in 'Password', with: "examplepassword"
      fill_in 'Password confirmation', with: "examplepassword"
      click_on 'Sign Up'
      click_on 'Create Game'
      fill_in 'Name', with: 'Testing Game'
      click_on 'Create Game'
      expect(page.body).to have_content("Your Cards")
    end
  end

  describe 'Spectate Game', type: :system do
    # it 'expects the page to change when the user clicks the spectate game button' do
    #   fill_in 'Name', with: 'Caleb'
    #   fill_in 'Password', with: "examplepassword"
    #   fill_in 'Password confirmation', with: "examplepassword"
    #   click_on 'Sign Up'
    #   click_on 'spectate'
    #   expect(page.body).to have_content("You are spectating the game")
    # end
  end
end
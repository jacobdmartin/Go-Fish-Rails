require "rails_helper"

RSpec.describe 'System', type: :system do
  let(:session1) { Capybara::Session.new(:selenium_chrome_headless, app) }

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
        click_on 'Log in'
      }.to_not change(User, :count)
      expect(page).to have_content('Pending Games')
    end

    it 'prevents login for blank name' do
      click_on 'Sign Up'
      expect(page).to have_content 'error'
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
      expect(click_on 'Join').to change(page)
    end
  end

  describe 'Spectate Game', type: :system do
    it 'expects the page to change when the user clicks the spectate game button' do
      fill_in 'Name', with: 'Caleb'
      fill_in 'Password', with: "examplepassword"
      fill_in 'Password confirmation', with: "examplepassword"
      click_on 'Sign Up'
      click_on 'Create Game'
      fill_in 'Name', with: 'Testing Game'
      click_on 'Create Game'
      expect(click_on 'Spectate').to change(page)
    end
  end

  describe 'Game', type: :system do
    before :each do
      visit root_path
      fill_in 'Name', with: 'Caleb'
      fill_in 'Password', with: "examplepassword"
      fill_in 'Password confirmation', with: "examplepassword"
      click_on 'Sign Up'
      click_on 'Create Game'
      fill_in 'Name', with: 'Testing Game'
      click_on 'Create Game'
    end

    it 'expects the game to contain 1 player' do
      click_on 'Join'
      expect(@game.players.count).to eq 1
    end

    it 'expects the game to not start because not enough people have joined yet' do
      click_on 'Join'
      expect(game.started).to eq false
    end

    it 'expects the game to have started because enough people have joined' do
      click_on 'Join'
      click_on 'Join'
      expect(game.players.count).to eq 2
      expect(game.started).to eq true
    end

    it 'expects the end game screen to pop up because the game has finished' do
      
    end

    it 'expects the game to automatically delete after all players exit the game' do
      
    end
  end
end
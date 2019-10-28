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

  describe 'Game', type: :system do
    let(:session1) { Capybara::Session.new(:selenium_chrome_headless, app) }
    let(:session2) { Capybara::Session.new(:selenium_chrome_headless, app) }

    it 'expects the game to contain 1 player' do
      log_in(user_fred, session1)
      expect {
        session1.click_on 'Create Game'
        session1.fill_in 'Name', with: 'Testing Game'
        session1.click_on 'Create Game'
      }.to change(GameUser, :count).by(1)
    end

    it 'expects the game to contain 2 players' do
      log_in(user_bill, session1)
      expect {
        session1.click_on 'Create Game'
        session1.fill_in 'Name', with: "Game 455"
        session1.click_on 'Create Game'
      }.to change(GameUser, :count).by(1)
      expect(GameUser.count).to eq(1)

      session2 do
          expect {
          click_on 'Create Game'
          fill_in 'Name', with: 'Testing Game'
          click_on 'Create Game'
        }.to change(GameUser, :count).by(1)
        expect(GameUser.count).to eq(2)
      end
    end

    it 'expects the page to contain 2 players' do
      log_in(user_bill, session1)
      session1.click_on 'Create Game'
      session1.fill_in 'Name', with: "Game 455"
      session1.click_on 'Create Game'
      expect(session1).to have_css(".player__list--text", count: 1)
      
      log_in(user_fred, session2)
      session2.click_on 'Join'
      expect(session2).to have_css(".player__list--text", count: 2)
      # session1.expect(refresh).to change(page)
    end
    
    it 'expects the game to have started because enough people have joined' do
      
    end
    
    it 'expects the end game screen to pop up because the game has finished' do
      
    end
    
    it 'expects the game to automatically delete after all players exit the game' do
      
    end
  end

  def log_in(existing_user, session)
    session.visit root_path
    session.click_on 'Sign In'
    session.fill_in 'Name', with: existing_user.name
    session.fill_in 'Password', with: existing_user.password
    session.click_on 'Log In'
  end
end
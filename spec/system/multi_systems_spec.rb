require "rails_helper"

RSpec.describe 'Game', type: :system do
  let(:session1) { Capybara::Session.new(:selenium_chrome_headless, app) }
  let(:session2) { Capybara::Session.new(:selenium_chrome_headless, app) }

  let(:user_fred) { create(:user, name: 'Fred', password: 'examplepassword')}
  let(:user_bill) { create(:user, name: 'Bill', password: 'examplepassword', password_confirmation: 'examplepassword')}


  it 'expects the game to contain 1 GameUser' do
    log_in(user_fred, session1)
    expect {
      session1.click_on 'Create Game'
      session1.fill_in 'Name', with: 'Testing Game'
      session1.click_on 'Create Game'
    }.to change(GameUser, :count).by(1)
  end

  it 'expects the game to contain 2 GameUsers' do
    log_in(user_bill, session1)
    expect { 
      session1.click_on 'Create Game'
      session1.fill_in 'Name', with: "Game 455"
      # session1.click_on 'btn-2-players'
      session1.click_on 'Create Game'
    }.to change(GameUser, :count).by(1)
    expect(GameUser.count).to eq(1)

    log_in(user_fred, session2)
    session2.click_on 'Join'
    expect(GameUser.count).to eq(2)
  end

  it 'expects the page to display 2 players', :focus do
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

  def log_in(existing_user, session)
    session.visit login_path
    session.fill_in 'Name', with: existing_user.name
    session.fill_in 'Password', with: existing_user.password
    session.click_on 'Log In'
  end
end
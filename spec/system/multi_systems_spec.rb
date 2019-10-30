require "rails_helper"

RSpec.describe 'Game', type: :system do
  let(:session1) { Capybara::Session.new(:selenium_chrome, app) }
  let(:session2) { Capybara::Session.new(:selenium_chrome_headless, app) }

  let(:user_fred) { create(:user, name: 'Fred', password: 'examplepassword')}
  let(:user_bill) { create(:user, name: 'Bill', password: 'examplepassword', password_confirmation: 'examplepassword')}


  it 'expects the game to contain 1 GameUser' do
    log_in(user_fred, session1)
    create_game("Test Game", session1)
    expect(GameUser.count).to eq(1)
  end

  it 'expects the game to contain 2 GameUsers' do
    log_in(user_bill, session1)
    create_game("Game 455", session1)
    expect(GameUser.count).to eq(1)

    log_in(user_fred, session2)
    session2.click_on 'Join'
    expect(GameUser.count).to eq(2)
  end

  it 'expects the page to display 2 players' do
    log_in(user_bill, session1)
    create_game("Game That Has Started", session1)
    expect(session1).to have_css(".player__list--text", count: 1)
    
    log_in(user_fred, session2)
    session2.click_on 'Join'
    expect(session2).to have_css(".player__list--text", count: 2)
    # session1.expect(refresh).to change(page) #look up documentation on refreshing a session page
  end
  
  it 'expects the game to have started because two people have joined' do
    log_in(user_bill, session1)
    create_game("Game That Has Started", session1)
    @game = Game.find_by(name: "Game That Has Started")
    expect(@game.go_fish.players.count).to eq(1)

    log_in(user_fred, session2)
    session2.click_on 'Join'
    @game.reload
    expect(@game.go_fish.players.count).to eq(2)
    expect(@game.go_fish.players[0].hand).to_not be_empty
  end

  it 'expects player 1 to be the current player' do
    log_in(user_bill, session1)
    create_game("Current Player Game", session1)
    @game = Game.find_by(name: "Current Player Game")

    log_in(user_fred, session2)
    session2.click_on 'Join'
    @game.reload
    expect(@game.go_fish.current_player).to eq(@game.go_fish.players[0])
  end

  describe 'turn', :focus do
    it 'expects current_player to have popup on their screen' do
      start_game_with_bill_and_fred
      session1.refresh
      expect(session1).to have_css(".overlay")
    end
  end
  
  describe 'the end of the game' do 
    it 'expects the end game screen to pop up because the game has finished' do
      
    end
    
    it 'expects the game to automatically delete after all players exit the game' do
      
    end
  end

  def log_in(existing_user, session)
    session.visit login_path
    session.fill_in 'Name', with: existing_user.name
    session.fill_in 'Password', with: existing_user.password
    session.click_on 'Log In'
  end

  def create_game(name, session)
    session.click_on 'Create Game'
    session.fill_in 'Name', with: name
    session1.choose('2 Players')
    session.click_on 'Create Game'
  end

  def start_game_with_bill_and_fred
    log_in(user_bill, session1)
    create_game("Current Player Game", session1)
    @game = Game.find_by(name: "Current Player Game")

    log_in(user_fred, session2)
    session2.click_on 'Join'
    @game.reload
  end
end
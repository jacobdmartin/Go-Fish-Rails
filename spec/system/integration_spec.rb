# require 'rack/test'

# require 'capybara'
# require 'capybara/dsl'
# ENV['RACK_ENV'] = 'test'
# require_relative '../../server'
# require 'selenium/webdriver'
# require 'webdrivers'

# RSpec.describe Server do
#   let(:button_one) {find('#one')}
#   let(:button_two) {find('#two')}
#   let(:button_three) {find('#three')}
#   let(:button_four) {find('#four')}
#   let(:button_five) {find('#five')}
#   let(:start_button) {find('#start')}

#   def start_game_with_two_cpus
#     visit '/'
#     click_on '2'
#   end

#   include Capybara::DSL 
#   before do
#     Capybara.app = Server.new
#   end

#   after do
#     Server.clear_game
#   end

#   it "logs in to a page with two players" do
#     visit '/'
#     click_on '1'
#     expect(page).to have_css('.player__list--text', count:2)
#     expect(page).to have_content('You')
#   end

#   it "logs in to a page with four players" do
#     visit '/'
#     click_on '3'
#     expect(page).to have_css('.player__list--text', count:4)
#     expect(page).to have_content('You')
#   end

#   it 'distributes cards based on number of players' do
#     visit '/'
#     click_on '1'
#     expect(page).to have_css("[data-test-id='player-bot1']")
#     expect(page).to have_css("[data-test-id='player-bot1']", text: "7")
#   end

#   it 'displays current players hand and matches header' do
#     visit '/'
#     click_on '2'
#     expect(page).to have_css(".your-hand-column", text: "Your Cards")
#     expect(page).to have_css(".your-matches-column", text: "Your Matches")
#   end

#   it 'displays current players hand and matches' do
#     visit '/'
#     click_on '2'
#     expect(page).to have_css(".your-hand")
#     expect(page).to have_css(".your-matches")
#   end

#   it 'displays a button that says it is your turn and they click in' do
#     start_game_with_two_cpus
#     click_on 'Take Turn'
#     expect(page).to have_css(".card-list-item")
#     expect(page).to have_css(".player-list-item")
#   end

#   # it 'puts a match in a players match pile' do
#   #   start_game_with_two_cpus
#   #   click_on 'Take Turn'

#   # end
# end
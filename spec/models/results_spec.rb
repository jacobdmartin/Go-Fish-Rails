require_relative 'results'
require_relative 'player'

RSpec.describe Results, type: :model do
  let(:player_dan) {Player.new("Dan")}
  let(:player_matt) {Player.new("Matt")}

  it 'returns a specific string saying the player went go fish' do
    # results = Results.new(player_dan, player_matt, "5")
    # expect(results.player_results[0]).to eq("Dan took a 5 from Matt")
  end
end
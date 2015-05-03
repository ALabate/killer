require 'rails_helper'

RSpec.describe Game, :type => :model do

	WebMock.allow_net_connect!

  context 'game with players' do 


		describe "#allocate_players_targets" do

			let!(:game){ create(:game) }
		  let!(:player1) { create(:participant, login: 'baillees', game_id: game.id) }
		  let!(:player2) { create(:participant, login: 'galopint' , game_id: game.id) }
		  let!(:player3) { create(:participant, login: 'bonoadri' , game_id: game.id) }

			it 'there is a target and hunter loop' do

				expect(game.players.count).to eq(3)
				game.allocate_players_targets



				expect(player1.target.target.target).to eq(player1)
				expect(player2.target.target.target).to eq(player2)
				expect(player3.target.target.target).to eq(player3)

				expect(player1.hunter.hunter.hunter).to eq(player1)
				expect(player2.hunter.hunter.hunter).to eq(player2)
				expect(player3.hunter.hunter.hunter).to eq(player3)

			end
		end
	end
end

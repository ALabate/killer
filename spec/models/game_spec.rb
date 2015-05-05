require 'rails_helper'

RSpec.describe Game, :type => :model do

	WebMock.allow_net_connect!

  context 'game with players' do 

  		let!(:game){ create(:game) }
		let!(:player1) { create(:participant, login: 'baillees', game_id: game.id) }
		let!(:player2) { create(:participant, login: 'galopint' , game_id: game.id) }
		let!(:player3) { create(:participant, login: 'bonoadri' , game_id: game.id) }
		let!(:player4) { create(:participant, login: 'apapoult' , game_id: game.id) }

		before do

			expect(game.players.count).to eq(4)
			game.allocate_players_targets

		end

		describe "#allocate_players_targets" do

			it 'there is a target and hunter loop' do

				expect(player1.target.target.target.target).to eq(player1)
				expect(player2.target.target.target.target).to eq(player2)
				expect(player3.target.target.target.target).to eq(player3)
				expect(player4.target.target.target.target).to eq(player4)

				expect(player1.hunter.hunter.hunter.hunter).to eq(player1)
				expect(player2.hunter.hunter.hunter.hunter).to eq(player2)
				expect(player3.hunter.hunter.hunter.hunter).to eq(player3)
				expect(player4.hunter.hunter.hunter.hunter).to eq(player4)


			end

		describe 'events' do

			context 'A kill B, B didnt kill his target and B confirm that A killed him'
					
				let!(:player_a) { player1 }
				
				let!(:player_b) { player1.target }

				let!(:player_b_target) { player_b.target }

				before do 
					player_a.target.kill!
					player_a.target.confirm_kill!
				end
				
				it 'B has no target anymore' do
					expect(player_b.target).to eq(nil)
				end

				it 'B has an unreached target' do
					expect(player_b.targets.unreached.first.pursued).to eq(player_b_target)
				end

				it 'B is dead' do
					expect(player_b.dead?).to eq(true)
				end

				it 'A is alive' do
					expect(player_a.alive?).to eq(true)
				end

				it 'A has a new target and the new target of A is the target of B' do
					expect(player1.target).to eq(player_b_target)
				end

			end

			context 'End of loop A kill B' do
				
				before do
					player1.target.kill!
					player1.target.confirm_kill!

					player1.target.kill!
					player1.target.confirm_kill!

					player1.target.kill!
					player1.target.confirm_kill!
				
				end

				it 'A target is A' do
					expect(player1.target).to eq(player1)
				end

			end
		end
	end
end

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

		describe "#killer" do

			context 'A kill B then A kill B then A kill C' do
				let(:cyril) { player1 }
				let(:nicolas){ cyril.target }
				let(:thomas){ nicolas.target }
				let(:joan){ thomas.target }

				before do 

					# cyril target is nicolas

					cyril.target.confirm_kill!
					cyril.target.kill!

					# cyril target is thomas

					cyril.target.confirm_kill!
					cyril.target.kill!

					# cyril target is joan

					cyril.target.confirm_kill!
					cyril.target.kill!

					# cyril target is himself but we don't care
				end

				it 'every cyril targets have cyril as its peope who killed him' do
					expect(nicolas.killer).to eq(cyril)
					expect(thomas.killer).to eq(cyril)
					expect(joan.killer).to eq(cyril)
				end
			end
		
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
				
				it 'B has no target anymore and no hunter anymore' do
					expect(player_b.target).to eq(nil)
					expect(player_b.hunter).to eq(nil)
				end

				it 'B killer is 1' do
					expect(player_b.killer).to eq(player_a)
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


			context 'A kill B and G kill A' do
				
				let!(:a) {player1}
				let!(:b) {player1.target}
				let!(:g) {player1.hunter}
				
				before do
					player1.target.kill!
					player1.target.confirm_kill!

					a.kill!
					a.confirm_kill!
				
				end

				describe 'A' do

					subject{ a }

					it 'A should have one killed target' do
						expect(a.targets.killed.count).to eq(1)
					end

					it 'A should have one unreached target' do
						expect(a.targets.unreached.count).to eq(1)
					end

					it 'A should not have current target and no current hunter' do
						expect(a.target).to eq(nil)
						expect(a.hunter).to eq(nil)
					end

					it 'A killer is G' do
						expect(a.killer).to eq(g)
					end
				end

				describe 'B' do

					subject{ b }

					it 'B should not have current target and no current hunter' do
						expect(b.target).to eq(nil)
						expect(b.hunter).to eq(nil)
					end

					it 'B killer is A' do
						expect(b.killer).to eq(a)
					end

					it 'B should have an unreached target' do
						expect(b.targets.unreached.count).to eq(1)
					end

				end

				describe 'G' do

					subject{ g }

					it 'G is alive' do
						expect(g.alive?).to eq(true)
					end

					it 'G should be alive ' do
						expect(g.alive?).to eq(true)
					end

					it 'G should have an new target ' do
						expect(g.target).to_not eq(nil)
					end
				end

			end

			context 'Kill confirmation asynchronously
				A ask kill B and B ask kill C then A confirm kill of A' do

				let!(:a) {player1}
				let!(:b) {a.target}
				let!(:c) {b.target}
				
				before do
					a.target.kill!
					b.target.kill!

					a.target.confirm_kill!
				
				end

				it 'A should have one killed target' do
					expect(a.targets.killed.count).to eq(1)
				end

				it 'A should have a new target and it should be the target of B' do
					expect(a.target).to eq(c)
				end

				it 'B should not have a current target' do
					expect(b.target).to eq(nil)
				end

				it 'B should have one unreached target' do
					expect(b.targets.unreached.count).to eq(1)
				end

			end


		end
	end
end

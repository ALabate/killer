class AddActualGame < ActiveRecord::Migration
  def change
  	Game.create!(beginning: '2015-05-05 8:00:00', ending: '2015-05-14 23:59:99')
  end
end

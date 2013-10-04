require 'monster'
require 'player'

module MonsterSelector

	attr_accessor :bestiary, :level, :monster, :levelcap

	def select_monster
		roll = rand(1..6) + rand(1..6)
		puts roll
		level_monster_to_retrieve = @player.level + roll - 7
		level_monster_to_retrieve = 1 if level_monster_to_retrieve < 1
		level_monster_to_retrieve = @levelcap if level_monster_to_retrieve > @levelcap
		monster_name = generate_monster_list(level_monster_to_retrieve)
	  @monster = Monster.load_monster(monster_name)
	end

	def generate_monster_list(monster_level)
		possible_monsters = []
		file = File.open('monsters.csv', 'r')
			file.each_line do |line|
				a = line.split(", ")
				possible_monsters << a if a[3].to_i == monster_level
			end
		file.close
		choice = possible_monsters[rand(possible_monsters.length)]
		puts "#{choice[0]} approaches."
		choice[0]
	end

end
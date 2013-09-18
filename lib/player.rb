require 'character'

class Player < Character

#	@@filepath = 'player.csv'

	@@player_classes = ["Mage", "Rogue", "Warrior"]
	@@player_one

	def self.generate_player
		args = {}
		Game.prompt("What is your name?")
		args[:name] = gets.chomp.capitalize
		puts "Hello, #{args[:name]}."

		until @@player_classes.include?(args[:player_class])
			puts "What class of adventurer are you?"
			Game.prompt(@@player_classes)
			args[:player_class] = gets.chomp.capitalize
		end

		puts "So, you're a #{args[:player_class]}"

		#generate rest of the stats from a file which
		#determines strengths and weaknesses based
		#on class choice

		args[:gold] = 0
		args[:level] = 1
		args[:exp] = 0
		args[:inventory] = "Sword"
		args[:hp] = 10
		args[:mp] = 10
		args[:attack] = 6
		args[:defense] = 4
		args[:acc] = 0.8
		args[:maxhp] = args[:hp]
		args[:maxmp] = args[:mp]

		player = Player.new(args)
		@@player_one = player

		player.save
	end

	def self.player_one
		@@player_one
	end

	def save
		file = File.open('player.csv', 'w')

		Hash[instance_variables.map { |name| [name, instance_variable_get(name)] } ]. each do |key,value|
	 		file.puts value
		end

		file.close
	end
end
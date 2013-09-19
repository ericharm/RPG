require 'character'

class Player < Character

	@@player_classes = ["Mage", "Rogue", "Warrior"]
	@@player_one = nil

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

		generate_stats = File.open('starting_stats.csv','r')

		generate_stats.each_line do |line|
			player_stats = line.split(", ")
			if player_stats[0] == args[:player_class]
				args[:gold] = player_stats[1].to_i
				args[:level] = player_stats[2].to_i
				args[:exp] = player_stats[3].to_i
			#	args[:inventory] = player_stats[4]
				args[:hp] = player_stats[5].to_i
				args[:mp] = player_stats[6].to_i
				args[:attack] = player_stats[7].to_i
				args[:defense] = player_stats[8].to_i
				args[:acc] = player_stats[9].to_f
				args[:maxhp] = args[:hp]
				args[:maxmp] = args[:mp]

				args[:inventory] = Inventory.new

				player = Player.new(args)
				@@player_one = player

				player.save
			end
		end

		generate_stats.close
	end

	def self.player_one
		@@player_one
	end

	def self.player_one=(player)
		@@player_one = player
	end

	def save
		file = File.open('player.csv', 'w')

		Hash[instance_variables.map { |name| [name, instance_variable_get(name)] } ]. each do |key,value|
			unless key == :inventory
		 		file.puts value
		 	else
		 		file.puts @@player_one.inventory.contents
		 	end

		end

		file.close
	end
end
require 'character'

class Player < Character

	@@player_classes = ["Mage", "Rogue", "Warrior"]
	@@player_one = nil

	def self.generate_player
		Game.prompt("What is your name?")
		name = gets.chomp.capitalize
		puts "Hello, #{name}."
		puts "What class of adventurer are you?"
		Game.prompt @@player_classes
		player_class = gets.chomp.capitalize until @@player_classes.include? player_class
		puts "So, you're a #{player_class}"
		args = generate_stats(name, player_class)
		player = Player.new(args)
		@@player_one = player
		player.save
	end

	def self.generate_stats(name, player_class)
		args = {}
		file = File.open('starting_stats.csv','r')
		file.each_line do |line|
			player_stats = line.split(", ")
			if player_stats[0] == player_class
				args[:name] = name
				args[:player_class] = player_class
				args[:gold] = player_stats[1].to_i
				args[:level] = player_stats[2].to_i
				args[:exp] = player_stats[3].to_i
				args[:inventory] = player_stats[4]
				args[:hp] = player_stats[5].to_i
				args[:mp] = player_stats[6].to_i
				args[:attack] = player_stats[7].to_i
				args[:defense] = player_stats[8].to_i
				args[:acc] = player_stats[9].to_f
				args[:maxhp] = args[:hp]
				args[:maxmp] = args[:mp]
				args[:inventory] = Inventory.new
			end
		end
		file.close
		return args
	end

	def self.load_player_from_file

		a = []
		args = {}

		file = File.open('player.csv', 'r')

		file.each_line do |line|
			a << line.chomp
		end

		args[:name] = a[0]
		args[:player_class] = a[1]
		args[:gold] = a[2].to_i
		args[:level] = a[3].to_i
		args[:exp] = a[4].to_i
		args[:inventory] = a[5]
		args[:hp] = a[6].to_i
		args[:mp] = a[7].to_i
		args[:attack] = a[8].to_i
		args[:defense] = a[9].to_i
		args[:acc] = a[10].to_f
		args[:inventory] = Inventory.new
		args[:maxhp] = a[11].to_i
		args[:maxmp] = a[12].to_i

		player = Player.new(args)
		load_inventory player
		Player.player_one = player
	end

	def self.load_inventory(target)
		attributes = []
		file = File.open('player.csv', 'r')
		file.each_line do |line|
			attributes << line.chomp
		end
		
		clean_items_string = attributes[13].tr('"[]',"")
		items_to_create = clean_items_string.split(", ")

		items_to_create.each do |item_name|
			item = Item.load_item_from_file(item_name)
			target.inventory.contents << item
		end
	end

	def self.player_one
		@@player_one
	end

	def self.player_one=(player)
		@@player_one = player
	end

	def list_stats
		puts "\n > > > #{@name.upcase}"
		puts "Class: #{@player_class}"
		puts "Exp: #{@exp} / #{@exp_next}		Level: #{@level}"
		puts "Gold: #{@gold}"
		puts "HP: #{@hp} / #{@maxhp}	MP: #{@mp} / #{@maxmp}"
		puts "Attack: #{@attack}	Defense: #{@defense}	Accuracy: #{@acc}"
		puts "Inventory: #{@inventory.list_items}"
	end

	def save
		file = File.open('player.csv', 'w')

		Hash[instance_variables.map { |name| [name, instance_variable_get(name)] } ]. each do |key,value|
				file.puts value
		end

		file.print @inventory.list_items
		file.close
		puts ". . . #{name} saved."
	end
end
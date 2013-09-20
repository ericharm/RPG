require 'player'
require 'battle'
require 'shop'

class Game

	@@actions = ['Fight', 'Shop', 'Inventory', 'Stats', 'Save', 'Quit']
	attr_accessor :player

	def self.prompt(text="")
		print "#{text} > "
	end

	def actions
		@@actions
	end

	def initialize
		saved_character = File.open('player.csv', 'r').gets
		if saved_character.nil?
			Player.generate_player
			get_action
		else
			Game.prompt "Continue saved character?"
			response = gets.chomp.downcase[0]
			if response == "y"
				Player.load_player_from_file
			else
				Player.generate_player
			end
			@player = Player.player_one
			get_action
		end
	end

	def get_action
		puts "\n > > > R P G"
		print actions
		Game.prompt
		result = gets.chomp.downcase.strip
		do_action(result)
		get_action unless result == 'quit'
	end

	def do_action(action)
		case action
			when 'fight'
				fight
			when 'shop'
				shop
			when 'inventory'
				inventory
			when 'stats'
				stats
			when 'save'
				save
			when 'quit'
				exit
			else
				puts "I don't know that command"
		end
	end

	def fight
		fight = Battle.new
	end

	def shop
		shop = Shop.new
	end

	def inventory
		puts @player.inventory.inv_menu
	end

	def stats
		@player.list_stats
	end

	def save
		@player.save
	end

end
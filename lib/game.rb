require 'player'
require 'battle'
require 'shop'

class Game

	@@actions = ['Fight', 'Shop', 'Inventory', 'Stats', 'Quit']

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
				Player.load_character_from_file(:player)
			else
				Player.generate_player
			end
			get_action
		end
	end


	def get_action
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
		puts Player.player_one.inventory
	end

	def stats
		Player.player_one.list_stats
	end

end
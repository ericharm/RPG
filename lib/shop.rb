require 'item'
require 'player'
require 'inventory'

class Shop

	@@choices = ['Buy', 'Sell']
	#shopkeeper's inventory organized in a hash with :item=>[price, quantity]
	@@shop_inventory = {:potion=>[10,10]}
	@@player = Player.player_one

	def initialize
		puts "Welcome to the shop. How can I help you?"
		Game.prompt(@@choices)
		choice = gets.downcase.chomp # until @@choices.include?(choice)

		case choice
			when 'buy'
				buy
			when 'sell'
				sell
			else
				"I don't understand."
		end
	end

	def buy
		puts "I have: #{@@shop_inventory}"
	end

	def sell
		puts "You have: #{Player.player_one.inventory}"
	end

end
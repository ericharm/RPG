require 'item'
require 'player'
require 'inventory'

class Shop

	@@choices = ['Buy', 'Sell']

	attr_accessor :shop_inventory, :target

	def initialize
		@shop_inventory = []
		@target = Player.player_one
		potion = Item.load_item_from_file "Potion"
		ether = Item.load_item_from_file "Ether"
		@shop_inventory << potion
		@shop_inventory << ether
		shop_menu
	end

	def shop_menu
		puts "\n > > > SHOP"
		puts "Welcome to the shop. How can I help you?"
		Game.prompt @@choices
		choice = gets.downcase.chomp

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
		print "I have: > > > "
		item_names = []
		@shop_inventory.each do |item|
			print "#{item.name}: #{item.price} Gold      "
			item_names << item.name
		end
		puts ""
		Game.prompt("What do you want to buy?")
		choice = gets.chomp.downcase.capitalize

		if item_names.include? choice
			item = Item.load_item_from_file(choice)
			if target.gold > item.price.to_i
				target.inventory.add_item(item)
				target.gold -= item.price.to_i
				puts "You bought #{item.name} for #{item.price} Gold."
			else
				puts "You can't afford that."
			end
		else
			puts "I don't have that."
		end
		# Player.player_one.inventory.add_item(item)
	end

	def sell
		puts "You have: > > > "
		item_names = []

		target.inventory.contents.each do |item|
			print "#{item.name}: #{item.price.to_i/2} Gold   /   "
		end
		#{target.inventory.list_items}"
		Game.prompt("What do you want to sell?")
		choice = gets.chomp.downcase.capitalize

		if target.inventory.list_items.include?(choice)
			target.inventory.contents.each do |item|
				if item.name == choice
					target.gold += item.price.to_i/2
					puts "You sold #{item.name} for #{item.price.to_i/2} Gold."
					target.inventory.remove_item(item)
					break
				end
			end
		else
			puts "You don't have one of those."
		end
	end
	
end
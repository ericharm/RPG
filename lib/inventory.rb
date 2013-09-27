class Inventory

	attr_accessor :contents

	@@choices = ["Use", "Equip", "Unequip", "Equipped", "Exit"]

	def initialize
		@contents = []
	end

	def inv_menu
		puts "\n > > > INVENTORY"
		puts list_items
		Game.prompt @@choices
		choice = gets.downcase.chomp
		do_action choice
	end

	def do_action(choice)
		case choice
			when 'use'
				use
			when 'equip'
				equip
			when 'unequip'
				unequip
			when 'equipped'
				equipped
			else
				puts "I don't understand."
		end
	end

	def use
		Game.prompt "Use what?"
		choice = gets.downcase.chomp.capitalize
		@contents.each do |item|
			if item.name == choice
				item.use( Player.player_one ) if item.is_usable?
				remove_item item if item.type == "Consumable"
				break
			end
		end
	end

	def equip
		equip_list = []
		equipable_item_names = []
		@contents.each do |item|
			if item.equipable
				equip_list << item
				equipable_item_names << item.name
			end
		end

		Game.prompt "#{equipable_item_names}\nEquip what?"
		choice = gets.downcase.chomp.capitalize

		if equipable_item_names.include?( choice )
			@contents.each { |item| item.equip(Player.player_one) if item.name == choice }
		else
			puts "You don't have that."
		end
	end

	def unequip
		equip_list = []
		@contents.each { |item| item.unequip(Player.player_one) if item.equipped }
	end

	def equipped
		@contents.each { |item|	print "#{item.name} " if item.is_equipped? }
	end

  def a_weapon_already_equipped?
  	equipped_items = []
    @contents.each { |item| equipped_items << item if item.type == "Weapon" && item.is_equipped? }
    true unless equipped_items.empty?
  end

	def list_items
		names_list = []
		@contents.each do |name|
			names_list << name.name
		end
		names_list
	end

	def add_item(item)
		@contents << item
	end

	def remove_item(item)
		@contents.delete item
	end
end
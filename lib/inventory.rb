class Inventory

  attr_accessor :contents

  @@choices = ["Use", "Equip", "Unequip", "Equipped", "Exit"]
  @@player = Player.player_one

  def initialize
    @contents = []
  end

  def inv_menu
    puts "\n > > > INVENTORY"
    p list_items
    Game.prompt @@choices
    choice = gets.downcase.chomp

    case choice
      when 'use'
        use
      when 'equip'
        equip
      when 'unequip'
        unequip
      when 'equipped'
        equipped
      when 'exit'
        #Game.get_action
      else
        puts "I don't understand."
    end

    inv_menu unless choice == 'exit'
  end

  def use
    Game.prompt "Use what?"
    choice = gets.downcase.chomp.capitalize
    item_to_use = @contents.find { |item| item.name == choice }
    item_to_use.use( Player.player_one ) if item_to_use.usable
    remove_item(item_to_use) if item_to_use.type == "Consumable"
  end

  def equip
    items = @contents.find_all { |item| item.type == 'Weapon' || item.type == 'Armor' }
    items.each { |item| p item.name }
    Game.prompt "Equip what?"
    choice = gets.downcase.chomp.capitalize
    item_to_equip = items.find { |item| item.name == choice }

    case item_to_equip.type
    when 'Weapon'
      if Player.player_one.equipped_weapon.nil?
        item_to_equip.equip( Player.player_one )
      else
        puts "You've already got a weapon equipped."
      end
    when 'Armor'
      if Player.player_one.equipped_armor.nil?
        item_to_equip.equip( Player.player_one )
      else
        puts "You've already got armor equipped."
      end
    else
      puts "You can't equip that type of thing."
    end

  end

  def unequip
    items_to_remove = @contents.find_all { |item| item.equipped == true }
    if items_to_remove.empty?
      puts "You have nothing equipped."
    else
      items_to_remove.each  { |item| item.unequip(Player.player_one) }
    end
  end

  def equipped
    equipped = @contents.find_all { |item| item.equipped == true }
    equipped.map { |item| p "#{item.type}: #{item.name}, + #{item.effect} #{item.stat}" }
  end

  def list_items
    items = []
    @contents.each { |item| items << item.name }
    items
  end

  def add_item(item)
    @contents << item
  end

  def remove_item(item)
    @contents.delete item
  end
end
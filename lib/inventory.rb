class Inventory

  attr_accessor :contents

  @@choices = ["Use", "Equip", "Unequip", "Equipped", "Exit"]
  @@player = Player.player_one

  def initialize
    @contents = []
  end

  def inv_menu
    puts "\n > > > INVENTORY"
    puts list_items.to_s
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
        puts 'Exiting. . .'
      else
        puts "I don't understand."
    end
    inv_menu unless choice == 'exit'
  end

  def use
    Game.prompt "Use what?"
    choice = gets.downcase.chomp
    item_to_use = @contents.find { |item| item.name.downcase == choice }
    if item_to_use.nil?
      puts "You don't have one of those."
    else
      item_to_use.use( Player.player_one ) if item_to_use.usable
      remove_item(item_to_use) if item_to_use.type == "Consumable"
    end
  end

  def equip
    items = @contents.find_all { |item| item.equipable == :true }
    p items.map { |item| item.name }
    Game.prompt "Equip what?"
    choice = gets.downcase.chomp.capitalize
    item_to_equip = items.find { |item| item.name == choice }

    if item_to_equip.nil?
      p "You can't equip that."
    else
      check_if_same_type_equipped(item_to_equip)
    end
  end

  def check_if_same_type_equipped(item_to_equip)
    items_equipped = @contents.find_all { |item| item.equipped == true }
    item_types_equipped = items_equipped.map { |item| item.type }

    if item_types_equipped.include?(item_to_equip.type)
      puts "You've already got an item of that type equipped."
    else
      item_to_equip.equip(Player.player_one)
    end
  end

  def unequip
    items_to_remove = @contents.find_all { |item| item.equipped == true }
    if items_to_remove.empty?
      puts "You have nothing equipped."
    else
      items_to_remove.each { |item| item.unequip( Player.player_one ) }
    end
  end

  def equipped
    equipped = @contents.find_all { |item| item.equipped == true }
    equipped.map { |item| p "#{item.type}: #{item.name}, + #{item.effect} #{item.stat}" }
    puts "Nothing equipped." if equipped.empty? == true
  end

  def list_items
    item_names = @contents.map { |item| item.name }
  end

  def list_items_equipped?(equipped)
    items = @contents.find_all { |item| item.equipped == equipped }
    item_names = items.map { |item| item.name }
  end

  def add_item(item)
    @contents << item
  end

  def remove_item(item)
    @contents.delete(item)
  end
end
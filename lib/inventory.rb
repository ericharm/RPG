class Inventory

  attr_accessor :contents

  @@choices = ["Use", "Equip", "Unequip", "Equipped", "Exit"]
  @@player = Player.player_one

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
    item_to_use = @contents.find { |item| item.name == choice }
    item_to_use.use( Player.player_one ) if item_to_use.usable
    remove_item(item_to_use) if item_to_use.type == "Consumable"
  end

  def equip
    weapons = @contents.find_all { |item| item.type == "Weapon" }
    weapons.each { |weapon| puts weapon.name }
    Game.prompt "Equip what?"
    choice = gets.downcase.chomp.capitalize
    weapon_to_equip = weapons.find { |item| item.name == choice }
    weapon_to_equip.equip( Player.player_one )
  end

  def unequip
    target = Player.player_one
    unless target.equipped_weapon.nil?
      puts "Removing #{target.equipped_weapon.name}."
      target.attack -= target.equipped_weapon.effect
      target.equipped_weapon.equipped = false
      target.equipped_weapon = nil 
    end
  end

  def equipped
    @contents.each { |item| print "#{item.name} " if item.equipped }
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
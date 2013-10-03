require 'item'
require 'player'
require 'inventory'

class Shop

  @@choices = ['Buy', 'Sell', 'Exit']

  attr_accessor :shop_inventory, :target

  def list_items
    items = []
    @shop_inventory.each { |item| items << item.name }
    items
  end

  def initialize
    @target = Player.player_one

    @shop_inventory = [ Item.load_item_from_file("Potion"), Item.load_item_from_file("Ether"),
                      Item.load_item_from_file("Sword"), Item.load_item_from_file("Leather") ]
    shop_menu
  end

  def shop_menu
    puts "\n > > > SHOP"
    puts "\n #{list_items}"
    puts "Welcome to the shop. How can I help you?"
    Game.prompt @@choices
    choice = gets.downcase.chomp

    case choice
      when 'buy'
        buy
      when 'sell'
        sell
      when 'exit'
        puts 'Goodbye.'
      else
        p "I don't understand."
    end

    shop_menu unless choice == 'exit'
  end

  def buy
    print "I have: > > >  "
    p @shop_inventory.map { |item| "#{item.name}: #{item.price} G"}
    Game.prompt("(#{target.gold} G)  What do you want to buy?")
    choice = gets.downcase.chomp.capitalize
    item_to_buy = @shop_inventory.find { |item| item.name == choice }

    unless item_to_buy.nil?
      if target.gold > item_to_buy.price.to_i
        target.inventory.add_item(item_to_buy)
        target.gold -= item_to_buy.price.to_i
        puts "You bought #{item_to_buy.name} for #{item_to_buy.price} Gold."
      else
        puts "You can't afford that."
      end
    end

    puts "I don't have one of those." if item_to_buy.nil?

  end

  def sell
    print "You have: > > > "
    p target.inventory.contents.map { |item| print "#{item.name}: #{item.price.to_i/2} Gold   " }
    Game.prompt("What do you want to sell?")
    choice = gets.chomp.downcase.capitalize

    if target.inventory.list_items.include?(choice)
      sold_item = target.inventory.contents.find { |item| item.name == choice }
      if sold_item.equipped?
        puts "You can not sell an equipped item."
      else
        target.gold += sold_item.price.to_i/2
        puts "You sold #{sold_item.name} for #{sold_item.price.to_i/2} Gold."
        target.inventory.remove_item(sold_item)
      end
    else
      puts "You don't have one of those."
    end
  end
  
end
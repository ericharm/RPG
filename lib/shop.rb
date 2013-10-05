require 'item'
require 'player'
require 'inventory'

class Shop

  @@choices = ['Buy', 'Sell', 'Exit']

  attr_accessor :shop_inventory, :target

  def initialize
    @target = Player.player_one
    @shop_inventory = []
    set_shop_inventory
    shop_menu
  end

  def set_shop_inventory
    all_items = []
    file = File.open('items.csv', 'r')
    file.each_line do |line|
      a = line.split(", ")
      name = a[0]
      all_items << name unless name == "Name"
    end
    all_items.each do |item| 
      @shop_inventory << Item.load_item_from_file(item) 
    end
  end

  def list_items
    @shop_inventory.map { |item| item.name }
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
    choice = gets.downcase.chomp
    item_to_buy = @shop_inventory.find { |item| item.name.downcase == choice }

    unless item_to_buy.nil?
      if target.gold > item_to_buy.price.to_i
        target.inventory.add_item(item_to_buy)
        target.change_stat(:gold, item_to_buy.price.to_i, :subtract)
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
      if sold_item.equipped? == true
        puts "You can not sell an equipped item."
      else
        target.change_stat(:gold, sold_item.price.to_i/2)
        puts "You sold #{sold_item.name} for #{sold_item.price.to_i/2} Gold."
        target.inventory.remove_item(sold_item)
      end
    else
      puts "You don't have one of those."
    end
  end
  
end
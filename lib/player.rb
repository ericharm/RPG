require 'character'

class Player < Character

  @@player_classes = ["Mage", "Rogue", "Warrior"]
  @@player_one = nil

  def self.generate_player
    Game.prompt("What is your name?")
    name = gets.chomp.capitalize
    puts "Hello, #{name}."
    puts "What class of adventurer are you?"
    Game.prompt @@player_classes
    player_class = gets.chomp.capitalize until @@player_classes.include? player_class
    puts "So, you're a #{player_class}"
    args = generate_stats(name, player_class)
    player = Player.new(args)
    @@player_one = player
    player.save
  end

  def self.generate_stats(name, player_class)
    args = {}
    file = File.open('starting_stats.csv','r')
    file.each_line do |line|
      stats = line.split(", ")
      if stats[0] == player_class
        args = { name: name, player_class: player_class, gold: stats[1].to_i, 
        level: stats[2].to_i, exp: stats[3].to_i, inventory: stats[4], 
        hp: stats[5].to_i, mp: stats[6].to_i, attack: stats[7].to_i, 
        defense: stats[8].to_i, acc: stats[9].to_i, maxhp: stats[5].to_i, 
        maxmp: stats[6].to_i, inventory: Inventory.new, exp_next: 40 }
      end
    end
    file.close
    return args
  end

  def self.load_player_from_file
    a = []
    file = File.open('player.csv', 'r')
    file.each_line { |line| a << line.chomp }

    args = { name: a[0], player_class: a[1], gold: a[2].to_i, level: a[3].to_i, 
      exp: a[4].to_i, inventory: Inventory.new, hp: a[6].to_i, mp: a[7].to_i, attack: a[8].to_i,
      defense: a[9].to_i, acc: a[10].to_i, maxhp: a[11].to_i, maxmp: a[12].to_i,
      exp_next: a[13].to_i }

    player = Player.new(args)
    load_inventory(player)
    Player.player_one = player
  end

  # move to inventory?
  def self.load_inventory(target)
    attributes = []
    file = File.open('player.csv', 'r')
    file.each_line do |line|
      attributes << line.chomp
    end
    
    clean_items_string = attributes[14].tr('"[]',"")
    items_to_create = clean_items_string.split(", ")

    items_to_create.each do |item_name|
      item = Item.load_item_from_file(item_name)
      target.inventory.contents << item
    end
  end

  def self.player_one
    @@player_one
  end

  def self.player_one=(player)
    @@player_one = player
  end

  def list_stats
    puts "\n > > > #{@name.upcase}"
    puts "Class: #{@player_class}"
    puts "Exp: #{@exp} / #{@exp_next}   Level: #{@level}"
    puts "Gold: #{@gold}"
    puts "HP: #{@hp} / #{@maxhp}  MP: #{@mp} / #{@maxmp}"
    puts "Attack: #{@attack}  Defense: #{@defense}  Accuracy: #{@acc}"
    puts "Inventory: #{@inventory.list_items}"
  end

  def save
    file = File.open('player.csv', 'w')

    Hash[instance_variables.map { |name| [name, instance_variable_get(name)] } ]. each do |key,value|
        file.puts value
    end

    file.print @inventory.list_items # unless @inventory.list_items == []
    file.close
    puts ". . . #{name} saved."
  end
end
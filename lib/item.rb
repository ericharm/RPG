class Item

  attr_accessor :name, :type, :stat, :effect, :price,
    :equipped, :equipable, :usable

  def self.load_item_from_file(name)
    file = File.open('items.csv', 'r')
      args = {}
      file.each_line do |line|
        attributes = line.split(", ")
        if attributes[0] == name
          args = { name: attributes[0], type: attributes[1], stat: attributes [2],
            price: attributes[3], effect: attributes[4], equipped: attributes[5],
            equipable: attributes[6], usable: attributes[7].chomp }
        end
      end
    file.close
    Item.new(args)
  end

  def initialize(args={})
    @name = args[:name] #strings
    @type = args[:type]
    @stat = args[:stat]
    @effect = args[:effect].to_i  #ints
    @price = args[:price].to_i
    @equipped = args[:equipped] #booleans
    @equipable = args[:equipable]
    @usable = args[:usable]
  end

  def use(target)
    case stat
    when "hp"
      target.hp+=@effect.to_i
      target.hp = target.maxhp if target.hp > target.maxhp
    end
    puts "Used #{@name}"
    puts "#{target.name}'s #{@stat.to_s} changed by #{@effect}."
  end

  def equip(target)
    case type
    when 'Weapon'
      target.equipped_weapon = self
      target.attack += target.equipped_weapon.effect
      puts "Equipped #{target.equipped_weapon.name}: + #{target.equipped_weapon.effect} #{target.equipped_weapon.stat}"
    when 'Armor'
      target.equipped_armor = self
      target.defense += target.equipped_armor.effect
      puts "Equipped #{target.equipped_armor.name}: + #{target.equipped_armor.effect} #{target.equipped_armor.stat}"
    else
      puts "That can't be equipped."
    end

    self.equipped = true
  end

  def unequip(target)
    case type
    when 'Weapon'
      target.attack -= target.equipped_weapon.effect
      puts "Removed  #{target.equipped_weapon.name}: - #{target.equipped_weapon.effect} #{target.equipped_weapon.stat}"
      target.equipped_weapon = nil
    when 'Armor'
      target.defense -= target.equipped_armor.effect
      puts "Removed  #{target.equipped_armor.name}: - #{target.equipped_armor.effect} #{target.equipped_armor.stat}"
      target.equipped_armor = nil
    else
      puts "That can't be unequipped."
    end

    self.equipped = false
  end

  def equipped?
    @equipped
  end

end
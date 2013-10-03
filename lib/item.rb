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
    while target.equipped_weapon.nil?
      target.equipped_weapon = self
      self.equipped = true
      puts "Equipped #{target.equipped_weapon.name}: + #{target.equipped_weapon.effect} #{target.equipped_weapon.stat}"
      target.attack += effect
    end
  end

  def unequip(target)
    
  end

end
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
            price: attributes[3], effect: attributes[4], equipped: false,
            equipable: attributes[6].to_sym, usable: attributes[7].chomp.to_sym }
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
    target.increase(@stat.to_sym, @effect.to_i)
    puts "Used #{@name}"
  end

  def equip(target)
    @equipped = true
    target.change_stat(@stat.to_sym, @effect)
    puts "Equipped #{name}: + #{effect} #{stat}"
  end

  def unequip(target)
    @equipped = false
    target.change_stat(@stat.to_sym, @effect, :subtract)
    puts "Unequipped  #{name}: - #{effect} #{stat}"
  end

  def equipped?
    @equipped
  end

end
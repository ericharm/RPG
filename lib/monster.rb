require 'character'

class Monster < Character

  def self.load_monster(name)
    file = File.open("monsters.csv", 'r')
      args= {}
      file.each_line do |line|
        data = line.split(", ")
        if data[0] == name
          args = { name: data[0], player_class: data[1], gold: data[2].to_i, 
            level: data[3].to_i, exp: data[4].to_i, inventory: data[5], 
            maxhp: data[6].to_i, hp: data[6].to_i, maxmp: data[7].to_i, 
            mp: data[7].to_i, attack: data[8].to_i, defense: data[9].to_i, 
            acc: data[10].to_i }
        end
      end
    file.close
    Monster.new(args)
  end

  def self.monsters_list
    file = File.open('monsters.csv', 'r')
    all_monsters = []
    file.each_line { |line| all_monsters << line.split(", ") }
    file.close
    all_monsters.map { |monster| monster[0] }
  end

end
require 'byebug'

class Board
  def self.print_grid(arr)
    arr.each do |subArr|
        subArr.each_with_index do |ele, i|
            if i == subArr.length - 1
                print ele
            else
                print ele.to_s + ' '
            end
        end
        puts
    end
  end

  def initialize(num)
    @grid = Array.new(num){Array.new(num,:N)}
    @size = num*num
  end

  def size
    @size
  end

  def [](array)
    return @grid[array[0]][array[1]]
  end

  def []=(pos, val)
    @grid[pos[0]][pos[1]] = val
  end

  def num_ships
    return @grid.flatten.count(:S)
  end

  def attack(pos)
    if self[pos] == :S
        self[pos] = :H
        puts 'you sunk my battleship!'
        return true
    else
        self[pos] = :X
        return false
    end 
  end

  def place_random_ships
    numToSet = self.size/4
    upperEnd = Integer.sqrt(self.size) - 1

    while numToSet > 0 do 
        i1 = rand(0..upperEnd)
        i2 = rand(0..upperEnd)

        test = [i1, i2]

        if self[test] != :S
            self[test] = :S
            numToSet -= 1
        end
    end
  end

  def hidden_ships_grid
    copy1 = @grid.map(&:clone)
    copy1.each do |subArr|
        subArr.each_with_index do |ele, i|
            if subArr[i] == :S
                subArr[i] = :N
            end
        end
    end
    return copy1
  end

  def cheat
    Board.print_grid(@grid)
  end

  def print
    Board.print_grid(self.hidden_ships_grid)
  end
end
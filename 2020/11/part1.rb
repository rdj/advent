#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)#.map{|s| s.to_i(10)}

def adjacent(map, row, col)
  spots = []
  (row-1..row+1).each do |r|
    next if r < 0 || r >= map.length
    (col-1..col+1).each do |c|
      next if c < 0 || c >= map[r].length || (r==row && c==col)
      spots.push map[r][c]
    end
  end
  spots
end

before = nil
now = $lines.map(&:dup)
round = 0
while now != before
  round += 1
  before = now.map(&:dup)
  (0...before.length).each do |row|
    (0...before[row].length).each do |col|
      if before[row][col] == '.'
        next
      end
      occupied = adjacent(before, row, col).count('#')
      case before[row][col]
      when 'L'
        if 0 == occupied
          now[row][col] = '#'
        end
      when '#'
        if occupied >= 4
          now[row][col] = 'L'
        end
      end
    end
  end
  # puts "=========================Round #{round}===================="
  # puts now.join("\n")
end

occupied = now.join("").count('#')
puts "Stable after round #{round}"
puts "#{occupied} seats occupied"

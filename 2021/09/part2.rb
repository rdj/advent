#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)#.map{|s| s.to_i(10)}

heights = []
$lines.each do |line|
  heights.push(line.chars.map(&:to_i))
end
$heights = heights

def get_adjacents(row, col)
  [[row - 1, col],
   [row + 1, col],
   [row, col - 1],
   [row, col + 1]].filter{|r,c| r >= 0 && c >=0 && r < $heights.length && c < $heights[r].length}
end

def get_basin_size(row, col)
  before = nil
  after = [[row, col]]
  while before != after
    before = after.dup
    before.each do |r,c|
      after.append(*get_adjacents(r,c).select{|r,c| $heights[r][c] != 9})
    end
    after.uniq!
    puts "Before #{before}"
    puts "After #{after}"
  end
  after.length
end

lows = []
(0...heights.length).each do |row|
  (0...heights[row].length).each do |col|
    adjacents = get_adjacents(row, col)
    vals = adjacents.map{|r,c| heights[r][c]}
    if vals.select{|v| v > heights[row][col]}.count == vals.count
      lows.push([row,col])
    end
  end
end

basin_sizes = lows.map{|r,c| get_basin_size(r,c)}
pp basin_sizes
biggest_basins = basin_sizes.sort[-3..]
puts biggest_basins.reduce(&:*)

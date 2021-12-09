#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)#.map{|s| s.to_i(10)}

heights = []
$lines.each do |line|
  heights.push(line.chars.map(&:to_i))
end

pp heights

lows = []
(0...heights.length).each do |row|
  (0...heights[row].length).each do |col|
    adjacents = [[row - 1, col],
                 [row + 1, col],
                 [row, col - 1],
                 [row, col + 1]].filter{|r,c| r >= 0 && c >=0 && r < heights.length && c < heights[r].length}
#    puts "#{row}, #{col} => #{adjacents}"
    vals = adjacents.map{|r,c| heights[r][c]}
    if vals.select{|v| v > heights[row][col]}.count == vals.count
      lows.push(heights[row][col])
    end
  end
end
puts lows.map{|l| l + 1}.sum

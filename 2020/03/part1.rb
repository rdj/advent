#!/usr/bin/env ruby

lines = ARGF.readlines.map(&:chomp)

row = 0
col = 0
trees = 0
ncols = lines[0].length
while row < lines.count
  c = lines[row][col]
  puts "#{row}, #{col} = #{c}"
  if lines[row][col] == '#'
    trees += 1
  end
  row += 1
  col = (col + 3) % ncols
end
puts trees

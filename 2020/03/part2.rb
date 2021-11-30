#!/usr/bin/env ruby

def treecount(lines, colinc, rowinc)
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
    row += rowinc
    col = (col + colinc) % ncols
  end
  return trees
end

lines = ARGF.readlines.map(&:chomp)

puts (
  treecount(lines, 1, 1) *
  treecount(lines, 3, 1) *
  treecount(lines, 5, 1) *
  treecount(lines, 7, 1) *
  treecount(lines, 1, 2) )

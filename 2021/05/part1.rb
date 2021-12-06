#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)#.map{|s| s.to_i(10)}

points = []

$lines.each do |line|
  x1s, y1s, x2s, y2s = /^(\d+),(\d+) -> (\d+),(\d+)$/.match(line).captures
  x1 = x1s.to_i
  y1 = y1s.to_i
  x2 = x2s.to_i
  y2 = y2s.to_i
  points.push([x1, y1, x2, y2])
end

xmax = points.map{|p| [p[0], p[2]].max}.max
ymax = points.map{|p| [p[1], p[3]].max}.max
puts "Grid is #{xmax} x #{ymax}"

rows = (0..ymax+1).map{|m| (0..xmax+1).map{|n| 0}}

points.each do |x1, y1, x2, y2|
  if x1 == x2
    ymin = [y1, y2].min
    ymax = [y1, y2].max
    (ymin..ymax).each do |y|
      rows[x1][y] += 1
    end
  elsif y1 == y2
    xmin = [x1, x2].min
    xmax = [x1, x2].max
    (xmin..xmax).each do |x|
      rows[x][y1] += 1
    end
  else
    # skip diagonals
  end
end

#puts rows.first.zip(*rows[2..]).map{|r| r.map{|n| n==0 ? '.' : n}.join(' ')}.join("\n")

pp rows.flatten.filter{|n| n > 1}.count

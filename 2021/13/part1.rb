#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)#.map{|s| s.to_i(10)}

def print_coords(coords)
  xmax = coords.map(&:first).max
  ymax = coords.map(&:last).max
  (0..ymax).each do |y|
    s = ''
    (0..xmax).each do |x|
      if coords.include?([x,y])
        s += '#'
      else
        s += '.'
      end
    end
    puts s
  end
end


coords = []
while line = $lines.shift
  if line.empty?
    break
  end
  coords.push(line.split(',').map(&:to_i))
end

folds = []
while line = $lines.shift
  axis,n = line.match(/([xy])=([0-9]+)/).captures
  folds.push [axis, n.to_i]
end

axes = ['x', 'y']

while fold = folds.shift
#  pp fold
  i = axes.index(fold[0])
  n = fold[1]
  coords.each do |c|
    if c[i] > n
#      puts "Folding #{c}"
      c[i] = n - (c[i] - n)
#      puts "to #{c}"
    end
  end
end

print_coords(coords)



# 14 = 0 = 7 - (14 - 7)
# 13 = 1 = 7 - (13 - 7)
# ..
# 8 = 6  = 7 - (8 - 7)
#          n - (c[i] - n)

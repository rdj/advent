#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)

seats = []

$lines.each do |line|
  rowstr = line[0...-3]
  colstr = line[-3..]
  rowbin = rowstr.tr('FB', '01')
  colbin = colstr.tr('LR', '01')
  row = rowbin.to_i(2)
  col = colbin.to_i(2)
  seatid = row * 8 + col
  seats.append(seatid)
end
seats.sort!
min = seats.min
(0...seats.length).each do |i|
  if seats[i] != min + i
    puts min + i
    exit
  end
end

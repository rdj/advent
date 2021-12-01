#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)

max_seat_id = 0

$lines.each do |line|
  rowstr = line[0...-3]
  colstr = line[-3..]
  rowbin = rowstr.tr('FB', '01')
  colbin = colstr.tr('LR', '01')
  row = rowbin.to_i(2)
  col = colbin.to_i(2)
  seatid = row * 8 + col
  puts "#{line} = #{rowstr} + #{colstr} = #{rowbin} + #{colbin} = #{row} + #{col} = #{seatid}"
  max_seat_id = [seatid, max_seat_id].max
end
puts max_seat_id

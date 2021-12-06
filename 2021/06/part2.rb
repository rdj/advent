#!/usr/bin/env ruby

RESET_TO = 6
START_AT = 8
DAYS = 256

$lines = ARGF.readlines.map(&:chomp)#.map{|s| s.to_i(10)}

yesterday = Hash.new(0)
$lines.first.split(',').map(&:to_i).each do |n|
  yesterday[n] += 1
end

today = nil
(1..DAYS).each do |day|
  today = Hash.new(0)
  yesterday.each do |n, count|
    if 0 == n
      today[RESET_TO] += count
      today[START_AT] += count
    else
      today[n - 1] += count
    end
  end
#  puts "After #{day} days: #{today.join(',')}"
  yesterday = today
end
puts "#{today.values.sum} total fish"

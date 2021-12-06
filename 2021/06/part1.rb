#!/usr/bin/env ruby

RESET_TO = 6
START_AT = 8
DAYS = 80

$lines = ARGF.readlines.map(&:chomp)#.map{|s| s.to_i(10)}

yesterday = $lines.first.split(',').map(&:to_i)
today = []
(1..DAYS).each do |day|
  today = []
  while m = yesterday.shift
    if 0 == m
      today.push RESET_TO
      today.push START_AT
    else
      today.push(m-1)
    end
  end
#  puts "After #{day} days: #{today.join(',')}"
  yesterday = today
end
puts "#{today.count} total fish"

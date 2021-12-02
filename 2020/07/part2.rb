#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)#.map(&:to_i(10))

$all_bags = {}

$lines.each do |line|
  bag_type, rest = /^(.*?) bags contain (.*)$/.match(line).captures
  bags = rest.split(/[.,] ?/)
  $all_bags[bag_type] = {}
  while e = bags.shift
    n, t = /^(no|\d+) (.*?) bags?/.match(e).captures
    if n != 'no'
      $all_bags[bag_type][t] = n.to_i
    end
  end
end

def count_sub_bags(bag)
  if bag.nil?
    return 0
  end
  count = 0
  bag.each do |color, n|
    puts "#{count} += #{n}"
    count += n
    nsub = count_sub_bags($all_bags[color])
    puts "#{count} += #{n} * #{nsub}"
    count += n * nsub
  end
  return count
end

pp count_sub_bags($all_bags["shiny gold"])

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
      $all_bags[bag_type][t] = n
    end
  end
end

def bag_contains(bag, color)
  if bag.nil?
    return false
  end
  if bag.keys.include?(color)
    return true
  end
  bag.keys.each do |sub_bag|
    if bag_contains($all_bags[sub_bag], color)
      return true
    end
  end
  return false
end

color_wanted = "shiny gold"
works = []
$all_bags.each do |color, contents|
  if bag_contains(contents, color_wanted)
    works.append(color)
  end
end

pp works.count

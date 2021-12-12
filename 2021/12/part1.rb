#!/usr/bin/env ruby

require 'set'

$lines = ARGF.readlines.map(&:chomp)#.map{|s| s.to_i(10)}

class Caves
  def initialize(lines)
    @caves = Hash.new{|e| Set.new}

    lines.each do |line|
      a,b = line.split('-')
      @caves[a] += [b]
      @caves[b] += [a]
    end
  end

  def build_routes
    @routes = build_routes_from('start', Set.new, false) # = part1 if you set it to true
    @routes.each{ |r| r.unshift 'start' } # only necessary for printing and comparing to given sample output
    @routes.length
  end

  def build_routes_from(node, visited, used_small)
    if node == 'end'
      return [[]]
    end

    visited = visited.dup + [node]
    subroutes = []
    @caves[node].each do |next_cave|
      if self.small?(next_cave) && visited.include?(next_cave)
        if used_small || next_cave == 'start'
          next
        else
          small = true
        end
      end

      self.build_routes_from(next_cave, visited, used_small || small).each do |new_route|
        subroutes.push([next_cave] + new_route)
      end
    end
    return subroutes
  end

  def small?(cave)
    cave.match?(/^[a-z]+$/)
  end
end

caves = Caves.new($lines)
puts caves.build_routes

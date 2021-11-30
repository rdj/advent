#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)

$expected = %w{ byr iyr eyr hgt hcl ecl pid }.sort
$optional = %w{ cid }

def valid_year(s, atleast, atmost)
  if !/^[0-9]{4}$/.match(s)
    return false
  end
  n = s.to_i
  if n < atleast || n > atmost
    return false
  end
  true
end

# hgt (Height) - a number followed by either cm or in:
#     If cm, the number must be at least 150 and at most 193.
#     If in, the number must be at least 59 and at most 76.
def valid_height(s)
  match = s.match(/^([0-9]+)(cm|in)$/)
  if !match
    return false
  end
  n, unit = match.captures
  n = n.to_i
  if 'cm' == unit
    return n >= 150 && n <= 193
  end
  return n >= 59 && n <= 76
end

def valid(passport)
  puts passport
  if $expected != (passport.keys - $optional).sort
    puts "missing keys"
    return false
  end

  # byr (Birth Year) - four digits; at least 1920 and at most 2002.
  if !valid_year(passport['byr'], 1920, 2002)
    puts "invalid byr"
    return false
  end

  # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
  if !valid_year(passport['iyr'], 2010, 2020)
    puts "invalid iyr"
    return false
  end

  # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
  if !valid_year(passport['eyr'], 2020, 2030)
    puts "invalid eyr"
    return false
  end

  if !valid_height(passport['hgt'])
    puts "invalid hgt"
    return false
  end

  # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
  if !/^#[0-9a-f]{6}$/.match(passport['hcl'])
    puts "invalid hcl"
    return false
  end

  # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
  if !%w{amb blu brn gry grn hzl oth}.include?(passport['ecl'])
    puts "invalid ecl"
    return false
  end

  # pid (Passport ID) - a nine-digit number, including leading zeroes.
  if !/^[0-9]{9}$/.match(passport['pid'])
    puts "invalid pid"
    return false
  end

  # cid (Country ID) - ignored, missing or not.
  puts "valid"
  true
end

nvalid = 0
passport = {}
$lines.each do |line|
  if line.empty?
    if valid(passport)
      nvalid += 1
    end
    passport = {}
  else
    line.split.map{|w| w.split(':')}.each do |k,v|
      passport[k] = v
    end
  end
end
puts nvalid

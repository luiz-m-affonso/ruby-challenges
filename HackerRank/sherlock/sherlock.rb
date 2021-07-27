#!/bin/ruby

require 'json'
require 'stringio'

def valid?(s)
  counts = Hash.new(0)
  s.split('').each { |elem| counts[elem] += 1 }
  same_repetition_count = Hash.new(0)
  counts.each do |elem|
    same_repetition_count[elem[1]] += 1
    return 'NO' if same_repetition_count.size > 2
  end

  if same_repetition_count.size > 1 && same_repetition_count.key(1) != 1
    if same_repetition_count.key(1).nil?
      return 'NO'
    else
      same_repetition_count[same_repetition_count.key(1) - 1] = same_repetition_count.delete same_repetition_count.key(1)
      return 'NO' if same_repetition_count.size > 1
    end
  end
  return 'YES'
end

fptr = File.open(ENV['OUTPUT_PATH'], 'w')

s = gets.to_s.rstrip

result = valid? s

fptr.write result
fptr.write "\n"

fptr.close()

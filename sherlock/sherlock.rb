#!/bin/ruby

require 'json'
require 'stringio'

# Definition of Method isValid for a Valid string.
def isValid(s)
  # Assignment of hash in variable count with method string split for n elements in hash.
  count = Hash.new(0)
  s.split('').each do |n|
    count[n] += 1
  end

  # Assignment of hash in variable count_repetition with re-assign incrementation calling n with key in hash count_repetition
  count_repetition = Hash.new(0)
  count.each do |n|
    count_repetition[n[1]] += 1
    return 'NO' if count_repetition.size > 2
  end

  # Conditional for size of count_repetition and for keys in count_repetition
  if count_repetition.size > 1 && count_repetition.key(1) != 1
    return 'NO' if count_repetition.key(1).nil?
  else
    # Calling count_repetition with key hash and decreasing
    # Calling method delete for count_repetition and calling key in hash
    count_repetition[count_repetition.key(1) - 1] = count_repetition.delete count_repetition.key(1)
    return 'NO' if count_repetition.size > 1
  end
  return 'YES'
end

fptr = File.open(ENV['OUTPUT_PATH'], 'w')

s = gets.to_s.rstrip

result = isValid s

fptr.write result
fptr.write "\n"

fptr.close

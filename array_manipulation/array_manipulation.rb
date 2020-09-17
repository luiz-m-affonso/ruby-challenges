#!/bin/ruby

require 'json'
require 'stringio'

# Array Manipulation with parameters n elements and queries it receives numbers as inputs.
def array_manipulation(n, queries)
  # Variable with assign of Array object with arguments n + 1 and 0
  array_object = Array.new(n + 1, 0)
  queries
    .inject(array_object) { |array, (x, y, z)|
  # Calling queries and aplying method .inject for Array object
  # with a new argument array and x y z which every element is a number received in input.
  array[x - 1] += z
  array[y] -= z
  array
}
    .inject([0, 0]) { |(max, sum), elem|
  # Applying inject method for array with and pass as arguments a max, sum and element
  sum += elem
  max = sum if sum > max
  [max, sum]
}
    .at(0)
  # Calling index of array in method .at
end

fptr = File.open(ENV['OUTPUT_PATH'], 'w')

nm = gets.rstrip.split
n = nm[0].to_i
m = nm[1].to_i
queries = Array.new(m)
m.times do |i|
  queries[i] = gets.rstrip.split(' ').map(&:to_i)
end
result = array_manipulation n, queries
fptr.write result
fptr.write "\n"

fptr.close

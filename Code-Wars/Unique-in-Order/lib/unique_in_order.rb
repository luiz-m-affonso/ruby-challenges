def unique_in_order(iterable)
  (iterable.is_a?(String) ? iterable.chars : iterable).chunk {|x| x}.map(&:first)
end
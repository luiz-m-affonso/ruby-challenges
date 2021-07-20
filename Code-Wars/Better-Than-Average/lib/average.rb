def better_than_average(arr, points)
  average = arr.reduce { |x, y| x + y } / arr.length;
  average > points ? false : true
end
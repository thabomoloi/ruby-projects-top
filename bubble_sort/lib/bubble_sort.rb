def bubble_sort(array)
  n = array.size
  n.times do
    (n - 1).times do |i|
      if array[i] > array[i+1]
        temp = array[i+1]
        array[i+1] = array[i]
        array[i] = temp
      end
    end
  end
  array
end

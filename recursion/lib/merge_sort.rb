def merge(left, right)
  result = []
  i, j = 0, 0

  while i < left.length && j < right.length
    if left[i] < right[j]
      result.push(left[i])
      i += 1
    else
      result.push(right[j])
      j += 1
    end
  end
  result.concat(left[i..]) if i < left.length
  result.concat(right[j..]) if j < right.length

  result
end

def merge_sort(array)
  return array if array.length <= 1
  mid = array.length / 2
  left = merge_sort(array[0...mid])
  right = merge_sort(array[mid..])
  merge(left, right)
end

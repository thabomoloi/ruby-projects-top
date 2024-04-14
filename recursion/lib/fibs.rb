def fibs(n)
  fibs_arr = [0, 1]
  return fibs_arr.first(n) if n <= 2
  (0...n - 2).to_a.each { |i| fibs_arr.push(fibs_arr[i] + fibs_arr[i+1])}
  fibs_arr
end

def fib_rec(n)
  return [0, 1].first(n) if n <= 2
  fibs_arr = fib_rec(n - 1)
  fibs_arr.push(fibs_arr[-1] + fibs_arr[-2])
end

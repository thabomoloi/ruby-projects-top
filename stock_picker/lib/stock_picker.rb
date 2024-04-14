def stock_picker(prices)
  buy_day, sell_day = (0...prices.size).to_a.combination(2).max_by do |buy, sell|
    prices[sell] - prices[buy]
  end
  [buy_day, sell_day]
end

require "spec_helper"
require_relative '../lib/stock_picker'

describe "#stock_picker" do
  it 'returns the pair of days' do
    expect(stock_picker([17,3,6,9,15,8,6,1,10])).to eq([1,4])
  end
end

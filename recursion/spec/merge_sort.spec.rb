require 'spec_helper'
require_relative '../lib/merge_sort'

RSpec.describe "#merge_sort" do
  it "returns a sorted array" do
    expect(merge_sort([3, 2, 1, 13, 8, 5, 0, 1])).to eq([0, 1, 1, 2, 3, 5, 8, 13])
    expect(merge_sort([105, 79, 100, 110])).to eq([79, 100, 105, 110])
    expect(merge_sort([5, 4, 3, 2, 1])).to eq([1, 2, 3, 4, 5])
    expect(merge_sort([1, 2, 3, 4, 5])).to eq([1, 2, 3, 4, 5])
    expect(merge_sort([1])).to eq([1])
    expect(merge_sort([])).to eq([])
  end

  it "does not modify the original array" do
    arr = [3, 2, 1]
    expect { merge_sort(arr) }.not_to change { arr }
  end

  it "handles an already sorted array" do
    expect(merge_sort([1, 2, 3, 4, 5])).to eq([1, 2, 3, 4, 5])
  end

  it "handles a reverse sorted array" do
    expect(merge_sort([5, 4, 3, 2, 1])).to eq([1, 2, 3, 4, 5])
  end
end

require 'spec_helper'
require_relative '../lib/bubble_sort'

RSpec.describe '#bubble_sort' do
  it 'sorts an array of numbers' do
    expect(bubble_sort([4, 3, 78, 2, 0, 2])).to eq([0, 2, 2, 3, 4, 78])
  end

  it 'returns an empty array when given an empty array' do
    expect(bubble_sort([])).to eq([])
  end

  it 'returns the same array when given a one-element array' do
    expect(bubble_sort([1])).to eq([1])
  end

  it 'sorts an array with duplicate numbers' do
    expect(bubble_sort([4, 3, 78, 2, 0, 2, 4])).to eq([0, 2, 2, 3, 4, 4, 78])
  end

  it 'sorts a reverse-ordered array' do
    expect(bubble_sort([5, 4, 3, 2, 1])).to eq([1, 2, 3, 4, 5])
  end
end

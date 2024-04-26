require 'spec_helper'
require_relative '../lib/linked_list'

describe LinkedList do
  let(:list) { LinkedList.new }

  describe '#initialize' do
    it 'creates an empty list' do
      expect(list.size).to eq(0)
      expect(list.head).to be_nil
      expect(list.tail).to be_nil
    end
  end

  describe '#append' do
    it 'adds an element to the end of the list' do
      list.append(1)
      list.append(2)
      expect(list.to_a).to eq([1, 2])
    end
  end

  describe '#prepend' do
    it 'adds an element to the beginning of the list' do
      list.prepend(1)
      list.prepend(2)
      expect(list.to_a).to eq([2, 1])
    end
  end

  describe '#at' do
    it 'returns the element at the specified index' do
      list.append(1)
      list.append(2)
      list.append(3)
      expect(list.at(1)).to eq(2)
    end

    it 'raises an IndexError for out-of-bounds index' do
      expect { list.at(0) }.to raise_error(IndexError)
    end
  end

  describe '#pop' do
    it 'removes and returns the last element from the list' do
      list.append(1)
      list.append(2)
      expect(list.pop).to eq(2)
      expect(list.to_a).to eq([1])
    end

    it 'raises an error if the list is empty' do
      expect { list.pop }.to raise_error('Empty list')
    end
  end

  describe '#contains?' do
    it 'returns true if the list contains the value' do
      list.append(1)
      list.append(2)
      expect(list.contains?(2)).to be(true)
    end

    it 'returns false if the list does not contain the value' do
      list.append(1)
      expect(list.contains?(2)).to be(false)
    end
  end

  describe '#insert_at' do
    it 'inserts an element at the specified index' do
      list.append(1)
      list.append(3)
      list.insert_at(2, 1)
      expect(list.to_a).to eq([1, 2, 3])
    end

    it 'raises an IndexError for out-of-bounds index' do
      expect { list.insert_at(1, 1) }.to raise_error(IndexError)
    end
  end

  describe '#remove_first' do
    it 'removes and returns the first element from the list' do
      list.append(1)
      list.append(2)
      expect(list.remove_first).to eq(1)
      expect(list.to_a).to eq([2])
    end

    it 'raises an error if the list is empty' do
      expect { list.remove_first }.to raise_error('Empty list')
    end
  end

  describe '#remove_last' do
    it 'removes and returns the last element from the list' do
      list.append(1)
      list.append(2)
      expect(list.remove_last).to eq(2)
      expect(list.to_a).to eq([1])
    end

    it 'raises an error if the list is empty' do
      expect { list.remove_last }.to raise_error('Empty list')
    end
  end

  describe '#remove_at' do
    it 'removes the element at the specified index' do
      list.append(1)
      list.append(2)
      list.append(3)
      list.remove_at(1)
      expect(list.to_a).to eq([1, 3])
    end

    it 'raises an IndexError for out-of-bounds index' do
      expect { list.remove_at(0) }.to raise_error(IndexError)
    end
  end

  describe '#each' do
    it 'iterates over each element in the list' do
      list.append(1)
      list.append(2)
      list.append(3)
      result = list.map { |value| value }
      expect(result).to eq([1, 2, 3])
    end
  end
end

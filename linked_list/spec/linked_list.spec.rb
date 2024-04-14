require 'spec_helper'
require_relative '../lib/linked_list'

describe LinkedList do
  let(:list) { LinkedList.new }

  describe "#append" do
    it "adds a new node containing value to the end of the list" do
      list.append(1)
      expect(list.to_s).to eq("( 1 ) -> nil")
      list.append(2)
      expect(list.to_s).to eq("( 1 ) -> ( 2 ) -> nil")
    end
  end

  describe "#prepend" do
    it "adds a new node containing value to the start of the list" do
      list.prepend(1)
      expect(list.to_s).to eq("( 1 ) -> nil")
      list.prepend(2)
      expect(list.to_s).to eq("( 2 ) -> ( 1 ) -> nil")
    end
  end

  describe "#size" do
    it "returns the total number of nodes in the list" do
      expect(list.size).to eq(0)
      list.append(1)
      expect(list.size).to eq(1)
      list.append(2)
      expect(list.size).to eq(2)
    end
  end

  describe "#head" do
    it "returns the first node in the list" do
      list.append(1)
      expect(list.head.value).to eq(1)
      list.prepend(2)
      expect(list.head.value).to eq(2)
    end
  end

  describe "#tail" do
    it "returns the last node in the list" do
      list.append(1)
      expect(list.tail.value).to eq(1)
      list.append(2)
      expect(list.tail.value).to eq(2)
    end
  end

  describe "#at" do
    it "returns the node at the given index" do
      list.append(1)
      list.append(2)
      list.append(3)
      expect(list.at(0).value).to eq(1)
      expect(list.at(1).value).to eq(2)
      expect(list.at(2).value).to eq(3)
    end
  end

  describe "#pop" do
    it "removes the last element from the list" do
      list.append(1)
      list.append(2)
      expect(list.pop.value).to eq(2)
      expect(list.to_s).to eq("( 1 ) -> nil")
    end
  end

  describe "#contains?" do
    it "returns true if the passed in value is in the list and otherwise returns false" do
      list.append(1)
      list.append(2)
      expect(list.contains?(1)).to be true
      expect(list.contains?(3)).to be false
    end
  end

  describe "#find" do
    it "returns the index of the node containing value, or nil if not found" do
      list.append(1)
      list.append(2)
      list.append(3)
      expect(list.find(2)).to eq(1)
      expect(list.find(4)).to be_nil
    end
  end

  describe "#to_s" do
    it "represents the LinkedList objects as strings" do
      list.append(1)
      list.append(2)
      list.append(3)
      expect(list.to_s).to eq("( 1 ) -> ( 2 ) -> ( 3 ) -> nil")
    end
  end

  describe "#insert_at" do
    it "inserts a new node with the provided value at the given index" do
      list.append(1)
      list.append(3)
      list.insert_at(2, 1)
      expect(list.to_s).to eq("( 1 ) -> ( 2 ) -> ( 3 ) -> nil")
    end
  end

  describe "#remove_at" do
    it "removes the node at the given index" do
      list.append(1)
      list.append(2)
      list.append(3)
      list.remove_at(1)
      expect(list.to_s).to eq("( 1 ) -> ( 3 ) -> nil")
    end
  end
end

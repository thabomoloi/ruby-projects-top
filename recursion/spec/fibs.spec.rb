require 'spec_helper'
require_relative '../lib/fibs'

RSpec.describe "Fibonacci" do
  describe "#fibs" do
    it "returns the correct Fibonacci sequence for n = 1" do
      expect(fibs(1)).to eq([0])
    end

    it "returns the correct Fibonacci sequence for n = 2" do
      expect(fibs(2)).to eq([0, 1])
    end

    it "returns the correct Fibonacci sequence for n = 5" do
      expect(fibs(5)).to eq([0, 1, 1, 2, 3])
    end

    it "returns the correct Fibonacci sequence for n = 10" do
      expect(fibs(10)).to eq([0, 1, 1, 2, 3, 5, 8, 13, 21, 34])
    end
  end

  describe "#fib_rec" do
    it "returns the correct Fibonacci sequence for n = 1" do
      expect(fib_rec(1)).to eq([0])
    end

    it "returns the correct Fibonacci sequence for n = 2" do
      expect(fib_rec(2)).to eq([0, 1])
    end

    it "returns the correct Fibonacci sequence for n = 5" do
      expect(fib_rec(5)).to eq([0, 1, 1, 2, 3])
    end

    it "returns the correct Fibonacci sequence for n = 10" do
      expect(fib_rec(10)).to eq([0, 1, 1, 2, 3, 5, 8, 13, 21, 34])
    end
  end
end

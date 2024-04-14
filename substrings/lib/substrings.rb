def substrings(string, dictionary)
  hash = Hash.new(0)
  str = string.downcase
  dictionary.each do |substr|
    count = str.scan(substr.downcase).count
    if count > 0
      hash[substr] = count
    end
  end
  hash
end

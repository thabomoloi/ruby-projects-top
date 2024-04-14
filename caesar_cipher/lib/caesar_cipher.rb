# frozen_string_literal: true

# Gets a character given start ascii (A or z), ord, and shift
def get_char(start, ord, shift)
  (start + (ord - start + shift) % 26).chr('utf-8')
end

def caesar_cipher(string, shift)
  shift = ((shift % 26) + 26) % 26
  shifted = string.split('').map do |char|
    ord = char.ord
    if ord.between?(65, 90) || ord.between?(97, 122)
      get_char(ord < 97 ? 65 : 97, ord, shift)
    else
      char
    end
  end
  shifted.join('')
end

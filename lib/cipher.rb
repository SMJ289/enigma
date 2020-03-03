module Cipher

  def char_set
    ("a".."z").to_a << " "
  end

  def shifted_char_set(shift)
    shifted_set = char_set.rotate(shift)
    char_set.zip(shifted_set).to_h
  end

  def shift_string(string, shifts)
    shifted_sets = {
      a: shifted_char_set(shifts[:a]),
      b: shifted_char_set(shifts[:b]),
      c: shifted_char_set(shifts[:c]),
      d: shifted_char_set(shifts[:d])
    }
    shift_chars(string, shifted_sets)
  end

  def unshift_string(string, shifts)
    unshifted_sets = {
      a: shifted_char_set(-shifts[:a]),
      b: shifted_char_set(-shifts[:b]),
      c: shifted_char_set(-shifts[:c]),
      d: shifted_char_set(-shifts[:d])
    }
    shift_chars(string, unshifted_sets)
  end

  def shift_chars(string, shifts)
    encrypted_message = []
    string.each_char.with_index do |char, index|
      if !char_set.include?(char)
        encrypted_message << char
      elsif index % 4 == 0
        encrypted_message << shifts[:a][char]
      elsif index % 4 == 1
        encrypted_message << shifts[:b][char]
      elsif index % 4 == 2
        encrypted_message << shifts[:c][char]
      else
        encrypted_message << shifts[:d][char]
      end
    end
    encrypted_message.join
  end

end

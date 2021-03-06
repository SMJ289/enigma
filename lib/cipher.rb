module Cipher

  def generate_char_set
    ("a".."z").to_a << " "
  end

  def generate_shifted_char_set(shift)
    shifted_set = generate_char_set.rotate(shift)
    generate_char_set.zip(shifted_set).to_h
  end

  def shift_message(message, shifts)
    shifted_sets = {
      a: generate_shifted_char_set(shifts[:a]),
      b: generate_shifted_char_set(shifts[:b]),
      c: generate_shifted_char_set(shifts[:c]),
      d: generate_shifted_char_set(shifts[:d])
    }
    shift_chars(message, shifted_sets)
  end

  def unshift_message(message, shifts)
    unshifted_sets = {
      a: generate_shifted_char_set(-shifts[:a]),
      b: generate_shifted_char_set(-shifts[:b]),
      c: generate_shifted_char_set(-shifts[:c]),
      d: generate_shifted_char_set(-shifts[:d])
    }
    shift_chars(message, unshifted_sets)
  end

  def shift_chars(message, shifts)
    lowercase_message = message.downcase
    char_set = generate_char_set
    lowercase_message.chars.map.with_index do |char, index|
      determine_shift(shifts, char, index, char_set)
    end.join
  end

  def determine_shift(shifts, char, index, char_set)
    return char if !char_set.include?(char)
    return shifts[:a][char] if index % 4 == 0
    return shifts[:b][char] if index % 4 == 1
    return shifts[:c][char] if index % 4 == 2
    return shifts[:d][char]
  end

end

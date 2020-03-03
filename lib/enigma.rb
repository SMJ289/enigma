require 'date'

class Enigma

  def initialize
    @offsets = {}
    @keys = {}
  end

  def generate_random_key
    numbers = []
    5.times { numbers << rand(9) }
    numbers.join
  end

  def generate_keys(key = generate_random_key)
    @keys = {
      a: key[0..1].to_i,
      b: key[1..2].to_i,
      c: key[2..3].to_i,
      d: key[3..4].to_i
    }
  end

  def generate_date
    Date::today.strftime("%d%m%y")
  end

  def square_date(date)
    date.to_i ** 2
  end

  def truncate_date(date)
    square_date(date).to_s[-4..-1]
  end

  def generate_offsets(date = generate_date)
    offset_values = truncate_date(date)
    @offsets = {
      a: offset_values[0].to_i,
      b: offset_values[1].to_i,
      c: offset_values[2].to_i,
      d: offset_values[3].to_i
    }
  end

  def generate_shifts
    { a: @keys[:a] + @offsets[:a],
      b: @keys[:b] + @offsets[:b],
      c: @keys[:c] + @offsets[:c],
      d: @keys[:d] + @offsets[:d] }
  end

  def char_set
    ("a".."z").to_a << " "
  end

  def shifted_char_set(shift)
    shifted_set = char_set.rotate(shift)
    char_set.zip(shifted_set).to_h
  end

  def shift_string(string)
    shifts = generate_shifts
    shifted_sets = {
      a: shifted_char_set(shifts[:a]),
      b: shifted_char_set(shifts[:b]),
      c: shifted_char_set(shifts[:c]),
      d: shifted_char_set(shifts[:d])
    }
    shift_chars(string, shifted_sets)
  end

  def unshift_string(string)
    shifts = generate_shifts
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

  def encrypt(string, key = generate_random_key, date = generate_date)
    generate_offsets(date)
    generate_keys(key)
    { encryption: shift_string(string), key: key, date: date }
  end

  def decrypt(string, key, date = generate_date)
    generate_offsets(date)
    generate_keys(key)
    { decryption: unshift_string(string), key: key, date: date }
  end

end

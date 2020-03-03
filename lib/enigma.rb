require_relative 'key_generator'
require_relative 'offset_generator'
require_relative 'shift_generator'
require_relative 'cipher'

class Enigma

  include KeyGenerator
  include OffsetGenerator
  include ShiftGenerator
  include Cipher

  def encrypt(string, key = generate_random_key, date = generate_date)
    offsets = generate_offsets(date)
    keys = generate_keys(key)
    shifts = generate_shifts(keys, offsets)
    { encryption: shift_string(string, shifts), key: key, date: date }
  end

  def decrypt(string, key, date = generate_date)
    offsets = generate_offsets(date)
    keys = generate_keys(key)
    shifts = generate_shifts(keys, offsets)
    { decryption: unshift_string(string, shifts), key: key, date: date }
  end

end

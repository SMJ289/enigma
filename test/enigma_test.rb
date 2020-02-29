require './test/test_helper'
require './lib/enigma'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_can_generate_random_key
    assert_equal 5, @enigma.generate_random_key.length
  end

  def test_it_can_generate_keys_hash
    @enigma.stubs(:generate_random_key).returns([1,0,5,8,9])

    expected = {
      a: [1,0],
      b: [0,5],
      c: [5,8],
      d: [8,9]
    }
    assert_equal expected, @enigma.make_keys
  end

  def test_it_can_generate_todays_date
    date = Date::today.strftime("%e%m%y")
    
    assert_equal date, @enigma.generate_date()
  end















  def test_it_can_encrypt
    skip
    expected = {
     encryption: "keder ohulw",
     key: "02715",
     date: "040895"
    }

    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
  end
end

# # decrypt a message with a key and date
# pry(main) > enigma.decrypt("keder ohulw", "02715", "040895")
# #=>
# #   {
# #     decryption: "hello world",
# #     key: "02715",
# #     date: "040895"
# #   }
#
# # encrypt a message with a key (uses today's date)
# pry(main)> encrypted = enigma.encrypt("hello world", "02715")
# #=> # encryption hash here
#
# #decrypt a message with a key (uses today's date)
# pry(main) > enigma.decrypt(encrypted[:encryption], "02715")
# #=> # decryption hash here
#
# # encrypt a message (generates random key and uses today's date)
# pry(main)> enigma.encrypt("hello world")
# #=> # encryption hash here

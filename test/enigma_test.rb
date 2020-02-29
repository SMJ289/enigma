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
    @enigma.stubs(:generate_random_key).returns([0,2,7,1,5])

    expected = {
      a: 2,
      b: 27,
      c: 71,
      d: 15
    }
    assert_equal expected, @enigma.generate_keys
  end

  def test_it_can_generate_todays_date
    date = Date::today.strftime("%e%m%y")

    assert_equal date, @enigma.generate_date()
  end

  def test_it_can_return_given_date
    assert_equal "040895", @enigma.generate_date("040895")
  end

  def test_it_can_square_date
    @enigma.stubs(:generate_date).returns("040895")

    assert_equal 1672401025, @enigma.square_date
  end

  def test_it_can_truncate_date
    @enigma.stubs(:square_date).returns(1672401025)
    assert_equal "1025", @enigma.truncate_date
  end

  def test_it_can_generate_offsets
    @enigma.stubs(:truncate_date).returns("1025")

    expected = {
      a: 1,
      b: 0,
      c: 2,
      d: 5
    }
    assert_equal expected, @enigma.generate_offsets
  end

  def test_it_can_generate_final_shifts
    expected_keys = {
      a: 2,
      b: 27,
      c: 71,
      d: 15
    }
    @enigma.stubs(:generate_keys).returns(expected_keys)

    expected_offsets = {
      a: 1,
      b: 0,
      c: 2,
      d: 5
    }
    @enigma.stubs(:generate_offsets).returns(expected_offsets)

    expected_shifts = {
      a: 3,
      b: 27,
      c: 73,
      d: 20
    }

    assert_equal expected_shifts, @enigma.generate_shifts
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

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
    @enigma.stubs(:generate_random_key).returns("02715")

    expected = {
      a: 2,
      b: 27,
      c: 71,
      d: 15
    }
    assert_equal expected, @enigma.generate_keys
  end

  def test_it_can_generate_todays_date
    date = Date::today.strftime("%d%m%y")

    assert_equal date, @enigma.generate_date
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

  def test_it_can_generate_char_set
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
      "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

    assert_equal expected, @enigma.char_set
  end

  def test_it_can_create_shifted_char_sets
    expected = {"a"=>"d","b"=>"e","c"=>"f","d"=>"g","e"=>"h","f"=>"i","g"=>"j",
     "h"=>"k","i"=>"l","j"=>"m","k"=>"n","l"=>"o","m"=>"p","n"=>"q","o"=>"r",
     "p"=>"s","q"=>"t","r"=>"u","s"=>"v","t"=>"w","u"=>"x","v"=>"y","w"=>"z",
     "x"=>" ","y"=>"a","z"=>"b"," "=>"c"}

    assert_equal expected, @enigma.shifted_char_set(3)
  end

  def test_it_can_shift_string
    expected_shifts = {
      a: 3,
      b: 27,
      c: 73,
      d: 20
    }
    @enigma.stubs(:generate_shifts).returns(expected_shifts)

    assert_equal "keder ohulw", @enigma.shift_string("hello world")
    assert_equal "keder ohulw!", @enigma.shift_string("hello world!")
    assert_equal "!hxeoosprrdx", @enigma.shift_string("!hello world")
    assert_equal "keder!sprrdx", @enigma.shift_string("hello! world")
  end

  def test_it_can_unshift_string
    expected_shifts = {
      a: 3,
      b: 27,
      c: 73,
      d: 20
    }
    @enigma.stubs(:generate_shifts).returns(expected_shifts)

    assert_equal "hello world", @enigma.unshift_string("keder ohulw")
    assert_equal "hello world!", @enigma.unshift_string("keder ohulw!")
    assert_equal "!hello world", @enigma.unshift_string("!hxeoosprrdx")
    assert_equal "hello! world", @enigma.unshift_string("keder!sprrdx")
  end

  def test_it_can_encrypt
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

   assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
   # @enigma.stubs(:generate_date).returns("040895")
   # assert_equal expected, @enigma.encrypt("hello world", "02715")
  end

  def test_it_can_decrypt
    skip
    expected_shifts = {
      a: 3,
      b: 27,
      c: 73,
      d: 20
    }
    @enigma.stubs(:generate_shifts).returns(expected_shifts)

    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

   assert_equal expected, @enigma.decrypt("keder ohulw", "02715", "040895")
   @enigma.stubs(:generate_date).returns("040895")
   assert_equal expected, @enigma.decrypt("keder ohulw", "02715")
  end

end

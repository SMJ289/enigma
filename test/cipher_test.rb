require './test/test_helper'
require './lib/enigma'

class CipherTest < Minitest::Test

  def setup
    @enigma = Enigma.new
    
  end

  def test_it_can_generate_char_set
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
      "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

    assert_equal expected, @enigma.generate_char_set
  end

  def test_it_can_create_shifted_char_sets
    expected = {"a"=>"d","b"=>"e","c"=>"f","d"=>"g","e"=>"h","f"=>"i","g"=>"j",
     "h"=>"k","i"=>"l","j"=>"m","k"=>"n","l"=>"o","m"=>"p","n"=>"q","o"=>"r",
     "p"=>"s","q"=>"t","r"=>"u","s"=>"v","t"=>"w","u"=>"x","v"=>"y","w"=>"z",
     "x"=>" ","y"=>"a","z"=>"b"," "=>"c"}

    assert_equal expected, @enigma.generate_shifted_char_set(3)
  end

  def test_it_can_shift_string
    shifts = {
      a: 3,
      b: 27,
      c: 73,
      d: 20
    }

    assert_equal "keder ohulw", @enigma.shift_string("hello world", shifts)
    assert_equal "keder ohulw!", @enigma.shift_string("hello world!", shifts)
    assert_equal "!hxeoosprrdx", @enigma.shift_string("!hello world", shifts)
    assert_equal "keder!sprrdx", @enigma.shift_string("hello! world", shifts)
  end

  def test_it_can_unshift_string
    shifts = {
      a: 3,
      b: 27,
      c: 73,
      d: 20
    }

    assert_equal "hello world", @enigma.unshift_string("keder ohulw", shifts)
    assert_equal "hello world!", @enigma.unshift_string("keder ohulw!", shifts)
    assert_equal "!hello world", @enigma.unshift_string("!hxeoosprrdx", shifts)
    assert_equal "hello! world", @enigma.unshift_string("keder!sprrdx", shifts)
  end

  def test_it_can_shift_chars
    shifts = {
      a: 3,
      b: 27,
      c: 73,
      d: 20
    }

    shifted_sets = {
      a: @enigma.generate_shifted_char_set(shifts[:a]),
      b: @enigma.generate_shifted_char_set(shifts[:b]),
      c: @enigma.generate_shifted_char_set(shifts[:c]),
      d: @enigma.generate_shifted_char_set(shifts[:d])
    }

    assert_equal "keder ohulw", @enigma.shift_chars("hello world", shifted_sets)
  end

  def test_it_can_determine_shift
    shifts = {
      a: 3,
      b: 27,
      c: 73,
      d: 20
    }

    shifted_sets = {
      a: @enigma.generate_shifted_char_set(shifts[:a]),
      b: @enigma.generate_shifted_char_set(shifts[:b]),
      c: @enigma.generate_shifted_char_set(shifts[:c]),
      d: @enigma.generate_shifted_char_set(shifts[:d])
    }

    char_set = @enigma.generate_char_set

    assert_equal "k", @enigma.determine_shift(shifted_sets, "h", 0, char_set)
    assert_equal "e", @enigma.determine_shift(shifted_sets, "e", 1, char_set)
    assert_equal "d", @enigma.determine_shift(shifted_sets, "l", 2, char_set)
    assert_equal "e", @enigma.determine_shift(shifted_sets, "l", 3, char_set)
    assert_equal "r", @enigma.determine_shift(shifted_sets, "o", 4, char_set)
    assert_equal "!", @enigma.determine_shift(shifted_sets, "!", 5, char_set)
  end
end

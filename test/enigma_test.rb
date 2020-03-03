require './test/test_helper'
require './lib/enigma'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_can_encrypt
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

   assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")

   @enigma.stubs(:generate_date).returns("040895")
   assert_equal expected, @enigma.encrypt("hello world", "02715")

   @enigma.stubs(:generate_random_key).returns("02715")
   assert_equal expected, @enigma.encrypt("hello world")
  end

  def test_it_can_decrypt
    decrypted = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    encrypted = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

   assert_equal decrypted, @enigma.decrypt("keder ohulw", "02715", "040895")

   @enigma.stubs(:generate_date).returns("040895")
   assert_equal decrypted, @enigma.decrypt("keder ohulw", "02715")
   assert_equal decrypted, @enigma.decrypt(encrypted[:encryption], "02715")
  end

end

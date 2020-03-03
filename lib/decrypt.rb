require './lib/enigma'
enigma = Enigma.new

handle = File.open(ARGV[0], "r")

message = handle.read.chomp

decrypted_message = enigma.decrypt(message, ARGV[2], ARGV[3])

File.write(ARGV[1], decrypted_message[:decryption])

puts "Created 'decrypted.txt' with the key #{ARGV[2]} and date #{ARGV[3]}"






# $ ruby ./lib/crack.rb encrypted.txt cracked.txt 240818
# Created 'cracked.txt' with the cracked key 82648 and date 240818

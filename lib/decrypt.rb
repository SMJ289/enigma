require './lib/enigma'
enigma = Enigma.new

encryption_file = ARGV[0]
decryption_file = ARGV[1]
key = ARGV[2]
date = ARGV[3]

handle = File.open(encryption_file, "r")

message = handle.read.chomp

decrypted_message = enigma.decrypt(message, key, date)

File.write(decryption_file, decrypted_message[:decryption])

puts "Created '#{decryption_file}' with the key #{key} and date #{date}"






# $ ruby ./lib/crack.rb encrypted.txt cracked.txt 240818
# Created 'cracked.txt' with the cracked key 82648 and date 240818

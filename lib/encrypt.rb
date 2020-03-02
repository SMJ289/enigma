require './lib/enigma'
enigma = Enigma.new

handle = File.open(ARGV[0], "r")

message = handle.read.chomp

encrypted_message = enigma.encrypt(message)

File.write(ARGV[1], encrypted_message[:encryption])

puts "Created 'encrypted.txt' with the key #{encrypted_message[:key]} and date #{encrypted_message[:date]}"

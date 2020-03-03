require './lib/enigma'
enigma = Enigma.new

message_file = ARGV[0]
encryption_file = ARGV[1]

handle = File.open(message_file, "r")

message = handle.read.chomp

encrypted_message = enigma.encrypt(message)

File.write(encryption_file, encrypted_message[:encryption])

puts "Created '#{encryption_file}' with the key #{encrypted_message[:key]} and date #{encrypted_message[:date]}"

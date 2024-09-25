# frozen_string_literal: true

require 'net/http'
require_relative "../../config/environment"

# Any benchmarking setup goes here...
num_users = 100
total_time = 0.0

uri = URI.parse("http://localhost:3000/users")

num_users.times do |i|
  email = "testuser#{i+100}@example.com"

  # Messen der Zeit für die Registrierung jedes Benutzers
  time = Benchmark.measure do
    # Verwenden von `Net::HTTP.post_form` zur Registrierung des Benutzers
    res = Net::HTTP.post_form(uri, {
      'user[email]' => email,
      'user[password]' => '12345678910',
      'user[password_confirmation]' => '12345678910'
    })


    # Überprüfen, ob die Registrierung erfolgreich war
    unless res.is_a?(Net::HTTPRedirection)
      puts "Fehler bei der Registrierung von Benutzer #{i}: #{res.body}"
      raise "Fehler bei der Registrierung: #{res.body}"
    end
  end

  # Gib die Zeit für die Registrierung dieses Benutzers aus
  puts "Durchlauf #{i}: #{time.real} Sekunden"

  # Summiere die verstrichene Zeit für diese Registrierung
  total_time += time.real
end

avg_time = total_time / num_users
puts "Durchschnittliche Zeit für die Registrierung von #{num_users} Nutzern: #{avg_time} Sekunden"

# frozen_string_literal: true

require 'net/http'
require_relative "../../config/environment"

# Any benchmarking setup goes here...
num_users = 100
total_time = 0.0

uri = URI.parse("http://localhost:3000/login")

num_users.times do |i|
  # Messen der Zeit für die Registrierung jedes Benutzers
  time = Benchmark.measure do
    # Verwenden von `Net::HTTP.post_form` zur Registrierung des Benutzers
    res = Net::HTTP.post_form(uri, {
      'email' => "testuser1@example.com",
      'password' => 'password1234'
    })


    # Überprüfen, ob die Registrierung erfolgreich war
    unless res.is_a?(Net::HTTPRedirection)
      puts "Fehler beim Login von Benutzer #{i}: #{res.body}"
      raise "Fehler beim Login: #{res.body}"
    end
  end

  # Gib die Zeit für die Registrierung dieses Benutzers aus
  puts "Durchlauf #{i}: #{time.real} Sekunden"

  # Summiere die verstrichene Zeit für diese Registrierung
  total_time += time.real
end

avg_time = total_time / num_users
puts "Gesamte Zeit für das Login von #{num_users} Nutzern: #{total_time} Sekunden"
puts "Durchschnittliche Zeit für das Login pro Nutzer: #{avg_time} Sekunden"

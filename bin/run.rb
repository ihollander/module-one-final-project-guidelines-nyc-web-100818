require_relative '../config/environment'

ui = UI.new
ui.run

# # 1. welcome user
# puts "Welcome to Hogwarts!"
# # 2. explain the game
# puts "This is a game where you befriend or defeat your fellow Hogwarts students."
# # 3. get user name
# print "Enter your name: "
# name = gets.chomp
#
# # 4. sort user into a house
# house = House.all.sample
# puts "#{name} is in house #{house.name}"
# puts "Your wand: wandy! Your patronus: cat! Your pet: snake!"
#
# # 5. show leaderboard (# students defeated/# students befriended)
# puts "The current leaderboard: "
# puts "You: Students defeated: 0, Students befriended: 0"
# puts "Ron: Students defeated: 0, Students befriended: 0"
#
# # 5a. if win condition is met (user or AI player), go to end screen (10)
#
# # 6. show next action (random encounter - keep track of who student has already encountered)
#
# # 7. show story text and turn options (compliment, taunt)
# puts "You meet Ron in the hallway. "
# puts "Some info about Ron: his pet, patonus, house, etc."
# puts "Taunt or compiment? [t/c]"
# input = gets.chomp
#
# # a. if taunt is picked, go to combat screen (8)
# if input == "t"
#   # 8. Combat screen: show player's stats and opponent's stats and prompt user to pick a spell to cast
#   puts "Your stats: HP: 10"
#   puts "Ron's stats: HP: 4"
#   puts "Pick a spell. 1) Explodo; 2) Hocus Pocus; 3) Alakazam"
#   spell = gets.chomp
#   # a. Show effect of spell. If opponent's hit points reach 0, go to combat over screen (8c).
#   puts "Explodo hit Ron! Ron's stats: HP: 1"
#
#   # b. Opponent casts spell. If player's charm points or hit points reach 0, go to combat over screen (8c). Otherwise, go to (8)
#   puts "Ron cast Magic Missile! Your stats: HP: 7"
#   # c. Combat over screen: show combat result (who won, how many power/popularity points they get, how many power/popularity points the opponent gets)
#   puts "You defeated ron!"
#
#   puts "The current leaderboard: "
#   puts "You: Students defeated: 1, Students befriended: 0"
#   puts "Ron: Students defeated: 0, Students befriended: 0"
# else # b. if compliment is picked, go to charm screen (9)
#   # 9. Charm combat screen: prompt the user to compliment the player
#   puts "Your stats: Charm Resistance: 10"
#   puts "Ron's stats: Charm Resistance: 2"
#   puts "Pick a nice thing to say. 1) You smell lovely! 2) I like your shoes. 3) Your pet rat is SO fuzzy!"
#   # a. Compliments decrease player's charm resistance by X points
#   charm = gets.chomp
#   puts "Ron is smitten! Ron's stats: Charm Resistance: 0;"
#   # b. When player or opponent's charm resistance is 0, end charm combat and go to leaderboard
#   puts "You charmed Ron!"
#
#   puts "The current leaderboard: "
#   puts "You: Students defeated: 0, Students befriended: 1"
#   puts "Ron: Students defeated: 0, Students befriended: 0"
# end
#
# # 10. Game over screen: if win condition is met, show the outcome and some story text
#
# puts "You won! You're the most popular kid in school."

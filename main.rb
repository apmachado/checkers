require_relative 'game_controller'

print "1. Humano \n"
print "2. NPCAleatório\n"
print "3. MinMaxAlphaBeta\n"
print "4. MinMaxCutOff\n"
print "5. MinMaxCutOffWeighted\n\n"

print "Selecione qual será o jogador 1: "
p1 = gets.chomp.to_i - 1

print "Selecione qual será o jogador 2: "
p2 = gets.chomp.to_i - 1
print "\n"


gameController = GameController.new(p1, p2)

print "#{PLAYERS[p1]} vs #{PLAYERS[p2]}\n"
gameController.run_game

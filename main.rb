require_relative 'game_controller'

print "1. Humano \n2. IA_1\n3. IA_2\n\n"

print "Selecione qual será o jogador 1: "
p1 = gets.chomp.to_i

print "Selecione qual será o jogador 2: "
p2 = gets.chomp.to_i
print "\n"


gameController = GameController.new(p1, p2)

gameController.run_game

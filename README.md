# Checkers
Abaixo seguem as regras que serão seguidas e, às quais, a implementação do jogo e a IA, deverão seguir.

Seção Um: Regras do jogo.

O tabuleiro e sua disposição

1.1 - O tabuleiro é composto de 64 quadrados, alternados entre claro e escuro dispostos num quadrado com 8 colunas e 8 linhas.<br> 
1.2 - No começo do jogo o tabuleiro é colocado para os jogadores de forma que o quadrado escuro é situado à esquerda mais próxima do jogador e o quadrado claro no lado direito.<br>
1.3 - No começo do jogo, um dos jogadores tem 12 peças claras e o outro 12 peças escuras e estas peças devem ser dispostas nos primeiros quadrados verdes mais próximos de cada jogador.<br>
1.4 - O jogador com as peças claras começam o jogo.

Ordem de jogada

1.5 - Para iniciar, os jogadores decidem por seleção aleatória quem irá escolher a sua cor.<br>
1.6 - O primeiro movimento é feito pelo jogador com as peças claras e seguida os jogadores vão alternando as jogadas a cada turno.

Os movimentos

1.7 - Fundamentalmente existem 4 tipos de movimentos: movimento ordinário de uma peça comum, movimento ordinário de uma dama, movimento de captura de uma peça comum e movimento de captura de uma dama.

Movimento ordinário de uma peça comum

1.8 - Um movimento ordinário de uma peça comum é a sua transferência diagonal pra frente à esquerda ou à direita por um quadrado para um quadrado vizinho imediato vacante.<br>
1.9 - Quando uma peça comum chega na linha mais longe à frente ela vira uma dama, e isso completa o turno da jogada. 

Movimento ordinário de uma dama

1.10 - Um movimento ordinário de uma dama é de um quadrado diagonalmente para frente ou para trás, esquerda ou direita, para um quadrado vizinho imediato vacante.


Movimento de captura de uma peça comum

1.11 - O movimento de captura de uma peça comum é a sua transferência de um quadrado sobre a diagonal adjacente para frente ocupada por uma peça do oponente (comum ou dama) para um quadrado vacante imediatamente após esse. Um movimento de captura é chamado de “pulo”. Ao completar o pulo a peça capturada é removida do tabuleiro.

Captura em geral

1.12 - Se um pulo cria imediatamente uma outra oportunidade de captura, então o movimento de captura da peça é continuado até que todos os pulos são completados. A única exceção é se uma peça comum chega na linha da dama, ela deve se tornar dama e não deverá fazer mais novos movimentos. 

1.13 - Todos os movimentos de captura são obrigatórios, seja ativamente ou passivamente. Se houver mais de uma opção de pulo, o jogador deverá selecionar qual pulo irá fazer. Uma vez iniciado, pulos múltiplos devem ser continuados até o fim. Uma peça só pode ser pulada uma vez durante um pulo múltiplo.

Movimento de captura de uma dama

1.14 - O movimento de captura de uma dama é similar ao de uma peça comum, mas pode ser feito para frente e para trás.

Movimentos ilegais

1.15 - Ao selecionar uma peça com possibilidade de movimentação que será jogada, o jogador não poderá mais escolher outra peça e deverá terminar a jogada com essa peça.

1.16 - Um movimento de captura deve ser executado, quando for possível.

1.17 - Todos os movimentos ilegais serão impedidos pela implementação do jogo, não sendo possível executá-los.

Resultado do jogo

1.18 - Só existem dois possíveis estado para definir: a vitória e empate.

Definição de vitória

1.19 - O jogo é vencido pelo jogador que pode fazer o último movimento, ou seja, não existe nenhum movimento disponível para o oponente no seu turno, seja por suas peças terem sido todas capturada ou pelas suas peças remanescentes estarem todas bloqueadas.

Definição de empate

1.20 - O jogo é empatado se, em qualquer estágio do jogo as duas condições abaixo forem satisfeitas:

Nenhum dos jogadores colocar uma de suas peças comuns na linha da dama, transformando sua peça comum em dama por, pelo menos, os últimos 40 movimentos.

Nenhum dos jogadores teve uma de suas peças removidas por, pelo menos, os últimos 40 movimentos.


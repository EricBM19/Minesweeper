Feature: Minesweeper

☀ bomb
! mined box
? posible bomb

"1, 2" means row 1 column 2
rows and columns starts in 1 (not 0)

Background:
Given a user opens the app

Scenario Outline: Default Counter, must show the amount of hidden mines in the board
Then the counter should show the following value: "10"

Scenario: Default Timer, stopped by default
Then the timer should show the following value: ""

Scenario: Default Status, alive
Then the status should be: "alive"

Scenario: Default cells status, clear and unmarked
Then all cells should be hidden
And all cells should not display any information

Scenario: Default board dimensions
Then the amount of wows should be ?
And the amount of columns should be ?

@manual !!MOCK UP!!  ?mockedTimer=999
Scenario: Exceeding the time limit
Given the user set the next timer value: "999"
and the user tags as mined "1-1"
Then the next value should be: "∞"

Scenario: Cuando el usuario cree que una celda esconde una mina, marca la celda como minada
When the user marks the box "1-1" as mined
Then the box "1-1" should display a mined symbol

Scenario: Cuando el usuario no puede determinar si una celda esconde una mina, marca la celda como uncertain
When the user marks the box "1-1" as uncertain
Then the box "1-1" should display a mined uncertain

Scenario: Desmarcar una celda minada, eliminar el simbolo de minado
//TODO

Scenario: Desmarcar una celda uncertain, eliminar el simbolo de uncertain
//TODO

Scenario Outline: Taggear una celda con ratón (botón derecho)
Given the user tags as "<current-tag>" the box "1, 1"
When the user right clicks on cell "1-1"
Then the box "1-1" should be "<next-tag>"

Examples:
| current-tag | next-tag |
| no-tag      | mined    |
| mined       | uncertain|
| uncertain   | no-tag   |


Scenario Outline: Changing the Counter value /// split
Given the Counter shows a "<CounterValue>"
When the user tags the box "1,1" aS "<Mark>"
Then the "ResultCounterValue" should change "1,1"

Example:
|  CounterValue  |  Mark  |  ResultCounterValue  |
|       10       |   !    |           9          |
|        9       |   ?    |          10          |
|        0       |   !    |          -1          |
|       -2       |   !    |          -3          |
 
Scenario: SI EL USUARIO PIERDE, SE DEBEN MOSTRAR LAS CELDAS MARCADAS INCORRECTAMENTE COMO MINADAS
Given the user TAGS AS MINED a box at row 1 and column 1
When THE USER UNLEASH THE CELL (?,?)
Then the row 1 and column 1 box should display A NON WELL TAGGED SYMBOL

Scenario: ALLOWING TO Reveal a box with a Mark
Given PONGO TAG A LA UNO UNO
WHEN DESTAPO LA UNO UNO
Then LA UNO UNO DEBE MOSTRARSE DESTAPADA

Scenario Outline: SI EL USUARIO DESTAPA UNA CELDA CON MINA, MUERE -> GAME OVER
Given the user reveal the box at "<Row>" and "<Column>"
When LA CELDA ? ? MUESTRA UN SIMBOLO DE MINA (O EXPLOSION?)
Then THE GAME SHOULD BE OVER

Example:
|  Row  |  Column  |
|   1   |    3     |
|   1   |    4     |
|   2   |    1     |
|   2   |    7     |
|   3   |    2     |
|   3   |    7     |
|   6   |    8     |
|   7   |    8     |
|   8   |    3     |
|   8   |    8     |

Scenario: Revealing all bombs when the player dies
wHEN the user reveal the box at row 1 and column 3
THEN all the bombs should be displayed

Scenario: Reveling all bombs marked with a ?     //GAME OVER ???
Given the user reveal the box at row 1 and column 3
When the bomb is revealed to the player
Then all boxes marked with an ? should be displayed

Scenario Outline: Revealing a box with bombs near & WITHOUT MINE!!!
WHEN the user reveal the box at "<Row>" and "<Column>"
THEN the box should display a "<Number>"   // ?? ?? ROW COLUMN

Example:
|  Row  |  Column  |  Number  |
|   1   |    1     |    1     |
|   1   |    2     |    2     |
|   2   |    2     |    3     |
|   7   |    3     |    1     |
|   3   |    6     |    2     |
|   7   |    7     |    3     |

Scenario: MOSTRAR UNA CAJA VACÍA, LAS QUE NO TIENEN MINA, NI MINAS ADYACENTES 
WHEN the user reveals the box at row 5 and column 1
THEN an empty box should appear

Scenario: Reveling AN EMPTY CELL, ALL THE SURROUNDING CELL MUST BE UNLEASHED
WHEN the user reveals an empty box at row 5 and column 1
Then TODAS LAS CELDAS VECINAS A LA 5,1 TIENEN QUE ESTAR DESTAPADAS


Scenario: UN VECINO DESTAPA UNA CELDA VACIA, LAS CELDAS ALREDEDEOR DE ELLA TAMBIEN SE TIENEN QUE DESTAPAR
WHEN the user reveals an empty box at row 5 and column 1
THEN LA CELDA 4-2 TIENEN TODOS LOS VECINOS DESTAPADOS


Scenario: The player wins -> DISABLE CONTROLS
Given the player wins the game
Then all buttons should be disabled except the reset button

Scenario: Winning without marking any box
gIVEN And didn't mark any box
WHEN the player wins the game 
Then all boxes that contains mines will be marked with an: "!"

Scenario: Reseting a game
Given the user presses the reset button
Then all boxes will be clear
And the timer should be: ""
And the Counter should be: "10"

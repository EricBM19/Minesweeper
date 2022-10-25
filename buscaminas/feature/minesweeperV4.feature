Feature: Minesweeper

! mined symbol
? uncertain mine

"1-1" means row 1, column 1
Rows and columns start at 1

Background:
Given a user opens the app

@done
Scenario Outline: Default Counter, must show the amount of hidden mines in the board
Then the counter should show the following value: "10"

@done
Scenario: Default Timer, stopped by default
Then the timer should show the following value: ""

@done
Scenario: Default Status, alive
Then the status should be: "😐"

@manual
Scenario: Default cells status, clear and untagged
Then all cells should not display any information

@done
Scenario: Default board dimensions
Then the amount of rows should be: 8
And the amount of columns should be: 8

@manual
Scenario: Activating the Timer
When the user reveals the box "1-1"
Then the Timer value should start counting

@done
Scenario: When the user thinks there is a mined box, then tags the box as mined
When the user marks the box "1-1" as "mined"
Then the box "1-1" should display a symbol: "!"

@done
Scenario: When the user thinks there can be a mine in one box, then tags the box as uncertain
When the user marks the box "1-1" as "uncertain"
Then the box "1-1" should display a symbol: "?"

@done
Scenario: When the user wants to remove a tag and let the box no-tag
When the user marks the box "1-1" as "no-tag"
Then the box "1-1" should display a symbol: ""

@done
Scenario Outline: Tagging/Untagging a box with the mouse (right click)
Given the user tags as "<current-tag>" the box "1-1"
When the user right clicks on cell "1-1"
Then the box "1-1" should be "<new-tag>"

Examples:
| current-tag | new-tag  |
| no-tag      | mined    |
| mined       | uncertain|
| uncertain   | no-tag   |

@done
Scenario Outline: Changing the Counter value by adding a mined tag
Given the Counter shows a "<current-value>"
When the user marks the box "<row-column>" as "mined"
Then the "<counter-value>" should change 

Examples:
| current-value |  row-column  | counter-value |
|       10      |     1-1      |       9       |
|        5      |     2-6      |       4       |

@done
Scenario: Revealing a tagged box must be allowed
Given the user loads "?Mockdata"
Given the user tags as "mined" the box "1-1"
When the user reveals the box "1-1"
Then the box "1-1" should reveal its content

@done
Scenario Outline: When the user reveals a mined box, the game ends with a game over
Given the user loads "?Mockdata"
When the user reveals the box "<Row-Column>"
Then the status should be: "💀"

Examples:
|  Row-Column  |
|     1-3      |
|     2-1      |
|     2-7      |
|     3-2      |
|     3-7      |
|     6-8      |
|     7-8      |
|     8-3      |
|     8-8      |

@done
Scenario Outline: Revealing a box with bombs near and without a mine
Given the user loads "?Mockdata"
When the user reveals the box "<Row-Column>"
Then the box "<Row-Column>" should display a "<Number>"

Examples:

|  Row-Column  |  Number  |
|     1-1      |    1     |
|     1-2      |    2     |
|     2-2      |    3     |
|     7-3      |    1     |
|     3-6      |    2     |

@done
Scenario: Showing an empty box, a box without number, mine or adjacent mines
Given the user loads "?Mockdata"
When the user reveals the box "3-4"
Then the box "3-4" should display ""

@done
Scenario Outline: An empty cell revealed by a neighbour, revealling surroindeing cells
Given the user loads "?Mockdata"
When the user reveals the box "3-4" 
Then the box "<Row-Column>" should display ""

Examples:

|  Row-Column  |
|     3-5      |
|     4-4      |
|     4-5      |
|     5-1      |
|     5-2      |
|     5-3      |
|     5-4      |
|     5-5      |
|     5-6      |
|     6-1      |
|     6-2      |
|     6-3      |
|     6-4      |
|     6-5      |
|     6-6      |
|     7-1      |
|     7-5      |
|     7-6      |
|     8-1      |
|     8-5      |
|     8-6      |

@manual
Scenario: Revealing all the cells without bomb, the player wins
When the user reveals all the cells without bombs
Then the player wins the game

@manual
Scenario: Reseting the Timer in the middle of one game
Given the user starts a game and waits "10" seconds
When the user resets
Then the timer value should be empty

@manual
Scenario: Reseting the Counter value
Given the user tags a box at "1-1" as mined
When the user presses the "reset" button
Then the Counter value should be: "10"

# Guardar en otra url el mapa mock para los scenarios que clican celdas concretas.
# Añadir Given.
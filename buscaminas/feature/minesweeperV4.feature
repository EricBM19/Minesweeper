Feature: Minesweeper

! mined symbol
? uncertain mine

"1-1" means row 1, column 1
Rows and columns start at 1

"""
| 1 | 2 | - | - | 1 | 1 | 1 | 1 |
| - | 3 | 3 | 2 | 1 | 2 | - | 2 |
| 2 | - | 1 | 0 | 0 | 2 | - | 2 |
| 1 | 1 | 1 | 0 | 0 | 1 | 1 | 0 |
| 0 | 0 | 0 | 0 | 0 | 0 | - | - |
| 0 | 0 | 0 | 0 | 0 | 0 | - | - |
| 0 | 1 | 1 | 1 | 0 | 0 | 3 | - |
| 0 | 1 | - | 1 | 0 | 0 | 2 | - |
"""

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

Scenario: When the user thinks there is a mined box, then tags the box as mined
When the user marks the box "1-1" as mined
Then the box "1-1" should display a mined symbol

Scenario: When the user thinks there can be a mine in one box, then tags the box as uncertain
When the user marks the box "1-1" as uncertain
Then the box "1-1" should display a uncertain symbol

Scenario: Untagging a box with a mined symbol
Given the user tags as mined: "1-1"
When the user tags again "1-1"
Then the tags should be: "uncertain symbol"

Scenario: Untagging a box with an uncertain symbol
Given the user has an uncertain tag over the box: "1-1"
When the user tags again "1-1"
Then the tags should be: ""

Scenario Outline: Tagging/Untagging a box with the mouse (right click)
Given the user tags as "<current-tag>" the box "1-1"
When the user right clicks on cell "1-1"
Then the box "1-1" should be "<new-tag>"

Examples:
| current-tag | new-tag |
| no-tag      | mined    |
| mined       | uncertain|
| uncertain   | no-tag   |

Scenario: Changing the Counter value by adding a mined tag
Given the Counter shows a "<current-value>"
When the user tags a box at "<Row-Column>" as mined
Then the "<Counter value>" should change 

Example:
| current-value |  Row-Column  | Counter Value |
|       10      |     1-1      |       9       |
|        5      |     2-6      |       4       |

Scenario: Revealing a tagged box must be allowed
Given the user tags the box at "1-1" as mined
When the user revals the box "1-1"
Then the box "1-1" should reveal its content

Scenario Outline: When the user reveals a mined box, the game ends with a game over
Given the user reveal the box at "<Row-Column>"
When the box reveals a mine box
Then the game should end

Example:
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

Scenario: Revealing all bombs when the player dies
When the user reveal the box at "1-3"
Then all the bombs should be displayed

Scenario: The game end with a game over and all the uncertaing tagged boxes reveal their bombs
When the user reveal the box at "1-3"
Then all boxes marked tagged as uncertain should be displayed

Scenario Outline: Revealing a box with bombs near and without a mine
When the user reveal the box at "<Row-Column>"
Then the box should display a "<Number>"

Example:

|  Row-Column  |  Number  |
|     1-1      |    1     |
|     1-2      |    2     |
|     2-2      |    3     |
|     7-3      |    1     |
|     3-6      |    2     |

Scenario: When the game is over and the user had tagged a box incorrectly, we should show the mistaken tagged cells
Given the user tags as mined a box at "1-1"
When the user unleash a mined cell at "2-1"
Then the "1-1" box should display a bad tagged mine symbol

Scenario: Showing an empty box, a box without number, mine or adjacent mines
When the user reveals the box at "3-4"
Then an empty box should appear

Scenario: Revealing an empty cell, then all the surrounding cells must be unleashed
When the user reveals the box at "3-4" 
Then all the adjacent boxes to "3-4" should be revealed

Scenario: An empty cell revealed by a neighbour, revealling surroindeing cells
When the user reveals the box at "3-4" 
Then the minefield should look like:
"""
| 1 | 2 | - | - | 1 | 1 | 1 | 1 |
| - | 3 | 3 | 2 | 1 | 2 | - | 2 |
| 2 | - | 1 | 0 | 0 | 2 | - | 2 |
| 1 | 1 | 1 | 0 | 0 | 1 | 1 | 0 |
| 0 | 0 | 0 | 0 | 0 | 0 | - | - |
| 0 | 0 | 0 | 0 | 0 | 0 | - | - |
| 0 | 1 | 1 | 1 | 0 | 0 | 3 | - |
| 0 | 1 | - | 1 | 0 | 0 | 2 | - |
"""

Scenario: Revealing all the cells without bomb, the player wins
When the user reveals all the cells without bombs
Then the player wins the game

Scenario: Disabling the cells when the player ends the game by revealing a bomb
Given the user loses
Then all the cells should be disabled

Scenario: Disabling the cells when the player wins
Given the player wins the game
Then all the cells should be disabled

Scenario: Reseting a game with tagged boxes
Given the user has tagged with a mined symbol boxes: "1-3" and "1-4"
When the user resets the game
Then all cells should be clear and without any information

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

@manual
Scenario: Exceding the time limit
Given the user set the next timer value: "999"
And the user tags as mined "1-1"
Then the next value should be: "∞"
Feature: Minesweeper

Background:
Given a user opens the app

Scenario: Default mine counter
Then the mine counter should show the following value: "10"

Scenario: Default timer
Then the timer should show the following value: ""

Scenario: Default status
Then the status should show the following value: "alive"

Scenario Outline: Pressing the right click of the mouse once
Given the user wants to tick one box
When the user presses the "<button>" button
Then the box should be marked with the following value: "<mark>"

Example: 
|    button   | mark |
| right-click |  !   |

Scenario Outline: Pressing the right click of the mouse two times
Given the user want to tick one box
And the user presses the "<button>" button
And the box is marked with the "<firstMark>"
When the user presses the "<button2>" button
Then the box should be marked with the following value: "<secondMark>"

Example:
|   button    | firstMark |   button2   | secondMark |
| right-click |     !     | right-click |      ?     |

Scenario Outline: Pressing the right click of the mouse three times
Given the user presses the "<button>" button
And the box is marked with the "<firstMark>"
And the user presses the "<button2>" button
And the box is marked with the "<secondMark>"
When the user presses the "<button3>" button
Then the box should be marked with the following value: "<thirdMark>"

Example:
|   button    | firstMark |   button2   | secondMark |   button3   | thirdMark |
| right-click |     !     | right-click |      ?     | right-click |           |

Scenario Outline: Pressing a box an there is a number
Given the user presses the "<button>" button to reveal the box content
And there are "<bombs>" near the box
Then the box should display a "<boxNumber>"
And the status should be: "alive"

|    button   |  bombs  |  boxNumber  |
| left-click |    1    |      1      |
| left-click |    2    |      2      |
| left-click |    3    |      3      |
| left-click |    4    |      4      |

Scenario Outline: Pressing a box an there is a bomb
Given the user presses the "<button>" button to reveal the box content
And there is a bomb in the box
Then the status should be: "dead"
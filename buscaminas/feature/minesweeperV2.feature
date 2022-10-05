Feature: Minesweeper

Background:
Given a user opens the app

Scenario: Default Counter
Then the counter should show the following value: "10"

Scenario: Default Timer
Then the timer should show the following value: ""

Scenario: Default Status
Then the status should be: "alive"

Scenario: Default MineSweeper (Manual?)
Then all the boxes should be availeable to click
//Comprobar que no este marcada

Scenario Outline: Marking a box with an !
Given the user wants to mark one box
When the user presses the button "<button>"
Then a "<mark>" should appear over the box
Explicar mejor concepto y mejor definido

Example:
|    button      | mark |
|  right-click   |  !   |

Scenario Outline: Marking a box with a ?
Given the user wants to mark one box
And the user presses the button "<button>"
And a "<mark>" should appear over the box
When the user presses the button "<button2>"
Then a "<mark2>" should appear over the box

Example:
|    button      | mark |    button2      | mark2 |
|  right-click   |  !   |   right-click   |   ?   |

Scenario Outline: Changing an ! to a ?
Given the user already marked one box with a "<mark>"
When the user presses the button "<button>"
Then the first mark should be changed to "<mark2>"

|  mark  |    button   |  mark2  |
|    !   | right-click |    ?    |

Scenario Outline: Clicking 3 times over a box with the right click
Given the user clicks the button "<button>"
And a "<mark>" appears over the box
And the user clicks the button "<button2>"
And a "<mark2" appears over the box
When the user clicks the button "<button3"
Then the box should display "<mark3>"

Example:
|    button      | mark |    button2      | mark2 |    button3    |  mark3  |
|  right-click   |  !   |   right-click   |   ?   |  right-click  |         |

Scenario: Reducing the Counter Value
Given the user wants to mark one box with an !
When the user adds the ! over one box
Then the Counter value should decrease

Scenario: Increasing the Counter Value
Given the user wants to remove one !
When the user clicks over the marked box
Then the Counter value should increase

Scenario: Decreasing the Counter value even more
Given the user has already marked 10 boxes with an !
When the user adds a new mark 
Then the Counter value should decrese to negative value

Scenario Outline: The player dies
Given the user clicks the box at "<Row>" and "<Column>"
When the bomb is revealed to the player
Then the status should be: "dead"

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

Scenario Outline: Revealing a box with 1 bomb near
Given the user clicks the box at "<Row>" and "<Column>"
When the box content is revealed
Then the box should display: "1"

|  Row  |  Column  |
|   1   |    1     |
|   1   |    5     |
|   1   |    6     |
|   1   |    7     |
|   1   |    8     |
|   2   |    5     |
|   3   |    3     |
|   4   |    1     |
|   4   |    2     |
|   4   |    3     |
|   4   |    6     |
|   4   |    7     |
|   5   |    7     |
|   5   |    8     |
|   7   |    2     |
|   7   |    3     |
|   7   |    4     |
|   8   |    2     |
|   8   |    4     |

Scenario Outline: Revealing a box with 2 bombs near
Given the user clicks the box at "<Row>" and "<Column>"
When the box content is revealed
Then the box should display: "2"

|  Row  |  Column  |
|   1   |    2     |
|   2   |    4     |
|   2   |    6     |
|   2   |    8     |
|   3   |    1     |
|   3   |    6     |
|   3   |    8     |
|   6   |    7     |
|   8   |    7     |

Scenario Outline: Revealing a box with 3 bombs near
Given the user clicks the box at "<Row>" and "<Column>"
When the box content is revealed
Then the box should display: "3"

|  Row  |  Column  |
|   2   |    2     |
|   2   |    3     |
|   7   |    7     |
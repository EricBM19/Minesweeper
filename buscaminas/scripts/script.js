var board = [];
var rows = 8;
var columns = 8;

var minesCount = 10;
var minesLocation = [];

var gameOver = false;

window.onload = function()
{
    startGame();
}

function startGame()
{
    document.getElementById("mines-counter").innerText = minesCount;
    setMines();

    for (let r = 0; r < rows; r++)
    {
        let rows = [];
        for(let col = 0; col < columns; col++)
        {
            let tile = document.createElement("div");
            tile.id = r.toString() + "-" + col.toString();
            tile.addEventListener("click", clickCells);
            document.getElementById("board").append(tile);
            rows.push(tile);
        }
        board.push(rows);
    }

    console.log(board);
}

function setMines()
{
    minesLocation.push("0-2");
    minesLocation.push("0-3");
    minesLocation.push("1-0");
    minesLocation.push("1-6");
    minesLocation.push("2-1");
    minesLocation.push("2-6");
    minesLocation.push("5-7");
    minesLocation.push("6-7");
    minesLocation.push("7-2");
    minesLocation.push("7-7");
}

function clickCells()
{

    let tile = this;

    if(minesLocation.includes(tile.id))
    {
        alert("GAME OVER");
        gameOver = true;
        return;
    }
}
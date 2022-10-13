var board = [];
var rows = 8;
var columns = 8;

var minesCount = 10;
var minesLocation = [];
var tilesClicked = 0;

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
    if(gameOver || this.classList.contains("tile-clicked"))
    {
        return;
    }

    let tile = this;

    if(minesLocation.includes(tile.id))
    {
        gameOver = true;
        revealMines();
        return;
    }

    let coords = tile.id.split("-");
    let r = parseInt(coords[0]);
    let c = parseInt(coords[1]);
    checkMines(r,c);
}

function revealMines()
{
    for(let r=0; r < rows; r++)
    {
        for(let c=0; c < columns; c++)
        {
            let tile = board[r][c];
            if(minesLocation.includes(tile.id))
            {
                tile.innerText = "☀";
                tile.style.backgroundColor="red";
            }
        }
    }
}

function checkMines(r, c)
{
    if(r < 0 || r >= rows || c < 0 || c >= columns)
    {
        return;
    }
    if(board[r][c].classList.contains("tile-clicked"))
    {
        return;
    }

    board[r][c].classList.add("tile-clicked");

    let minesFound = 0;

    minesFound += checkTile(r-1, c-1);
    minesFound += checkTile(r-1, c);
    minesFound += checkTile(r-1, c+1);

    minesFound += checkTile(r, c-1);
    minesFound += checkTile(r, c+1);

    minesFound += checkTile(r+1, c-1);
    minesFound += checkTile(r+1, c);
    minesFound += checkTile(r+1, c+1);

    if(minesFound > 0)
    {
        board[r][c].innerText = minesFound;
    }
    else
    {
        checkMines(r-1, c-1);
        checkMines(r-1, c);
        checkMines(r-1, c+1);

        checkMines(r, c-1);
        checkMines(r, c+1);

        checkMines(r+1, c-1);
        checkMines(r+1, c);
        checkMines(r+1, c+1);
    }
}

function checkTile(r, c)
{
    if(r < 0 || r >= rows || c < 0 || c >= columns)
    {
        return 0;
    }

    if (minesLocation.includes(r.toString() + "-" + c.toString()))
    {
        return 1;
    }
    return 0;
}
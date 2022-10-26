/* eslint-disable no-undef */
const { Given, When, Then } = require('@cucumber/cucumber');
const { expect } = require('@playwright/test');

const url = 'http://127.0.0.1:5500/index.html';

Given('a user opens the app', async () => 
{
	await page.goto(url);
});

Then('the counter should show the following value: {string}', async (string) => 
{
  let counter = await page.locator('data-test-id=counter').innerText();
  expect(counter).toBe(string);
});

Then('the timer should show the following value: {string}', async (string) => 
{  
  let timer = await page.locator('data-test-id=time').innerText();
  expect(timer).toBe(string);
});

Then('the status should be: {string}', async (string) =>
{
  let status = await page.locator('data-test-id=status').innerText();
  expect(status).toBe(string);
});

Then('the amount of rows should be: {int}', async (int) => 
{
  let board = await page.locator('data-test-id=minefield').locator('div');
  let lastCell = await board.last().getAttribute('id');
  let rowId = await lastCell.split("-")[0];
  expect(parseInt(rowId)).toBe(int-1);
});

Then('the amount of columns should be: {int}', async (int) => 
{
  let board = await page.locator('data-test-id=minefield').locator('div');
  let lastCell = await board.last().getAttribute('id');
  let colId = await lastCell.split("-")[1];
  expect(parseInt(colId)).toBe(int-1);
});

When('the user marks the box {string} as {string}', async (string, string2) =>
{
  var tileId = 'data-test-id=' + string;
  if(string2 == "mined")
  {
    await page.click(tileId, {button: 'right'});
  }
  else if(string2 == "uncertain")
  {
    await page.click(tileId, {button: 'right'});
    await page.click(tileId, {button: 'right'});
  }
  else if(string2 == 'no-tag')
  {
    await page.click(tileId, {button: 'right'});
    await page.click(tileId, {button: 'right'});
    await page.click(tileId, {button: 'right'});
  }
});

Then('the box {string} should display a symbol: {string}', async (string, string2) =>
{
  if(string2 == 'no-tag')
  {
    string2 = '';
  }
  let tile = await page.locator('data-test-id=' + string).innerText();
  expect(tile).toBe(string2);
});

Given('the user tags as {string} the box {string}', async (string, string2) => 
{
  var tileId = 'data-test-id=' + string2;
  if(string == "mined")
  {
    await page.click(tileId, {button: 'right'});
  }
  else if(string == "uncertain")
  {
    await page.click(tileId, {button: 'right'});
    await page.click(tileId, {button: 'right'});
  }
});

When('the user right clicks on cell {string}', async (string) => 
{
  var tileId = 'data-test-id=' + string;
  await page.click(tileId, {button: 'right'});

});

Then('the box {string} should be {string}', async (string, string2) =>
{
  if(string2 == 'no-tag')
  {
    string2 = '';
  }
  else if(string2 == 'mined')
  {
    string2 = '!';
  }
  else if(string2 == 'uncertain')
  {
    string2 = '?';
  }
  let tile = await page.locator('data-test-id=' + string).innerText();
  expect(tile).toBe(string2);
});

Given('the Counter shows a {string}', async (string) => 
{
  let board = await page.locator('data-test-id=minefield').locator('div');
  let counterValue = 10 - parseInt(string);

  for(i = 1; i <= counterValue; i++)
  {
    var boardId = await board.nth(i).getAttribute('id');
    await page.click('id=' + boardId, {button: 'right'});
  }
});

Then('the {string} should change', async (string) =>
{
  let counter = await page.locator('data-test-id=counter').innerText();
  expect(counter).toBe(string);
});

Given('the user loads {string}', async (string) => 
{
   await page.goto(url + string);
});

When('the user reveals the box {string}', async (string) =>
{
  var tileId = 'data-test-id=' + string;
  await page.click(tileId);
});

Then('the box {string} should reveal its content', async (string) => 
{
  var tileId = 'data-test-id=' + string;
  var tile = await page.locator(tileId);
  await expect(tile).toHaveAttribute('class', 'tile-clicked x1');
});

Then('the box {string} should display a {string}', async (string, string2)  =>
{
  let tile = await page.locator('data-test-id=' + string).innerText()

  expect(tile).toBe(string2);

});

Then('the box {string} should display {string}', async (string, string2) =>
{
  let tile = await page.locator('data-test-id=' + string).innerText()
  expect(tile).toBe(string2);
});

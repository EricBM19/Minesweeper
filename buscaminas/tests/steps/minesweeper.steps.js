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
});

Then('the box {string} should display a symbol: {string}', async (string, string2) =>
{
  let tile = await page.locator('data-test-id=' + string).innerText();
  expect(tile).toBe(string2);
});
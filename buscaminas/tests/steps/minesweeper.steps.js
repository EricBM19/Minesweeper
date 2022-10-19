/* eslint-disable no-undef */
const { Given, When, Then } = require('@cucumber/cucumber');
const { expect } = require('@playwright/test');

const url = 'http://127.0.0.1:5500/main.html';

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
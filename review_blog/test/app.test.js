import { test, expect } from '@playwright/test';

const BASE_URL = 'http://localhost:3000';

test('Login (Normal), View Profile and Logout', async ({ page }) => {
  //Login
  // Navigate to the main page
  await page.goto(BASE_URL);
  // Click on the login link
  await page.getByRole('link', { name: 'Login' }).click();
  // Fill in the email and password fields
  await page.getByRole('textbox', { name: 'Email' }).click();
  await page.getByRole('textbox', { name: 'Email' }).fill('alice@example.com');
  await page.getByRole('textbox', { name: 'Password' }).click();
  await page.getByRole('textbox', { name: 'Password' }).fill('password');
  // Click the login button
  await page.getByRole('button', { name: 'Login' }).click();
  // Verify successful login
  await expect(page.getByText('Logged in!')).toBeVisible();

  //View Profile
  // Navigate to the profile page
  await page.getByRole('link', { name: 'Profile' }).click();
  // Verify profile information is displayed
  await expect(page.getByText('Email: alice@example.com')).toBeVisible();

  //Logout
  // Listen for the next dialog message
  page.once('dialog', async (dialog) => {
    console.log(`Dialog message: ${dialog.message()}`);
    await dialog.accept(); // Accept the confirmation (click "OK")
  });
  // Click the logout link
  await page.getByRole('link', { name: 'Logout' }).click();
  // Verify successful logout
  await expect(page.getByText('Logged out!')).toBeVisible();
});

test('Login (Alternative - Missing Field)', async ({ page }) => {
  // Navigate to the main page
  await page.goto(BASE_URL);
  // Click on the login link
  await page.getByRole('link', { name: 'Login' }).click();
  // Fill in only the email field
  await page.getByRole('textbox', { name: 'Email' }).click();
  await page.getByRole('textbox', { name: 'Email' }).click();
  await page.getByRole('textbox', { name: 'Email' }).fill('alice@example.com');
  // Leave the password field empty
  // Click the login button
  await page.getByRole('button', { name: 'Login' }).click();
  // Verify error message for missing password
  await expect(page.getByText('Invalid email or password')).toBeVisible();
});

test('Login (Exceptional - SQL Injection)', async ({ page }) => {
  // Navigate to the main page
  await page.goto(BASE_URL);
  // Click on the login link
  await page.getByRole('link', { name: 'Login' }).click();
  // Attempt SQL injection in the email field
  await page.getByRole('textbox', { name: 'Email' }).click();
  await page.getByRole('textbox', { name: 'Email' }).fill('\' OR \'x\'=\'x\' -- ');
  // Fill in the password field with arbitrary data
  await page.getByRole('textbox', { name: 'Password' }).click();
  await page.getByRole('textbox', { name: 'Password' }).fill('anything');
  // Click the login button
  await page.getByRole('button', { name: 'Login' }).click();
  // Verify that login was successful (indicating vulnerability)
  await expect(page.getByText('Logged in!')).toBeVisible();

  //Logout
  // Listen for the next dialog message
  page.once('dialog', async (dialog) => {
    console.log(`Dialog message: ${dialog.message()}`);
    await dialog.accept(); // Accept the confirmation (click "OK")
  });
  // Click the logout link
  await page.getByRole('link', { name: 'Logout' }).click();
  // Verify successful logout
  await expect(page.getByText('Logged out!')).toBeVisible();
});

test('Create Review (Normal) and Delete Review', async ({ page }) => {
  // Navigate to the main page
  await page.goto(BASE_URL);
  // Click on the login link
  await page.getByRole('link', { name: 'Login' }).click();
  // Fill in the email and password fields
  await page.getByRole('textbox', { name: 'Email' }).click();
  await page.getByRole('textbox', { name: 'Email' }).fill('alice@example.com');
  await page.getByRole('textbox', { name: 'Password' }).click();
  await page.getByRole('textbox', { name: 'Password' }).fill('password');
  // Click the login button
  await page.getByRole('button', { name: 'Login' }).click();
  await expect(page.getByText('Logged in!')).toBeVisible();
  // Click on Reviews and New Review
  await page.getByRole('link', { name: 'Reviews' }).click();
  await page.getByRole('link', { name: 'New Review' }).click();
  // Fill in the review form
  await page.getByRole('spinbutton', { name: 'Rating' }).click();
  await page.getByRole('spinbutton', { name: 'Rating' }).fill('5');
  await page.getByRole('textbox', { name: 'Title' }).click();
  await page.getByRole('textbox', { name: 'Title' }).fill('Test Review');
  await page.getByRole('checkbox', { name: 'Action' }).check();
  // Submit the review
  await page.getByRole('button', { name: 'Create Review' }).click();
  await expect(page.getByText('Review created!')).toBeVisible();
  
  //Delete Review
  // Listen for the next dialog message
    page.once('dialog', async ( dialog ) => {
        console.log( `Dialog message: ${ dialog.message() }` );
        await dialog.accept(); // Accept the confirmation (click "OK")
    } );
    // Click the delete link for the review
    await page.getByRole('link', { name: 'Delete Review' }).click();
    // Verify the review was deleted
    await expect(page.getByText('Review deleted!')).toBeVisible();
});

test('Create Comment (Normal), Delete Comment', async ({ page }) => {
  // Navigate to the main page
  await page.goto(BASE_URL);
  // Click on the login link
  await page.getByRole('link', { name: 'Login' }).click();
  // Fill in the email and password fields
  await page.getByRole('textbox', { name: 'Email' }).click();
  await page.getByRole('textbox', { name: 'Email' }).fill('alice@example.com');
  await page.getByRole('textbox', { name: 'Password' }).click();
  await page.getByRole('textbox', { name: 'Password' }).fill('password');
  // Click the login button
  await page.getByRole('button', { name: 'Login' }).click();
  await expect(page.getByText('Logged in!')).toBeVisible();
  // Navigate to the specific review
  await page.getByRole('link', { name: 'Reviews' }).click();
  // Click on the review titled "Great Game!"
  await page.getByRole('link', { name: 'Great Game!' }).click();
  // Fill in and submit the comment form
  await page.locator('#comment_body').click();
  await page.locator('#comment_body').fill('Test Comment');
  await page.getByRole('button', { name: 'Post Comment' }).click();
  // Verify the comment was added
  await expect(page.getByText('Comment added!')).toBeVisible();
  await expect(page.getByText('alice: Test Comment Delete').first()).toBeVisible();

  //Delete Comment
  //Listen for the next dialog message
  page.once('dialog', async (dialog) => {
    console.log(`Dialog message: ${dialog.message()}`);
    await dialog.accept(); // Accept the confirmation (click "OK")
  });
  // Click the delete link for the comment
  await page.getByRole('link', { name: 'Delete', exact: true }).click();
  // Verify the comment was deleted
  await expect(page.getByText('Comment deleted!')).toBeVisible();

});

test('Create Comment (Alternative - Missing Field)', async ({ page }) => {
  // Navigate to the main page
  await page.goto(BASE_URL);
  // Click on the login link
  await page.getByRole('link', { name: 'Login' }).click();
  // Fill in the email and password fields
  await page.getByRole('textbox', { name: 'Email' }).click();
  await page.getByRole('textbox', { name: 'Email' }).fill('alice@example.com');
  await page.getByRole('textbox', { name: 'Password' }).click();
  await page.getByRole('textbox', { name: 'Password' }).fill('password');
  // Click the login button
  await page.getByRole('button', { name: 'Login' }).click();
  await expect(page.getByText('Logged in!')).toBeVisible();
  // Navigate to the specific review
  await page.getByRole('link', { name: 'Reviews' }).click();
  // Click on the review titled "Best RPG ever"
  await page.getByRole('link', { name: 'Great adventure' }).click();
  //Submit the comment form
  await page.getByRole('button', { name: 'Post Comment' }).click();
  // Verify the comment error message
  await expect(page.getByText('Comment cannot be empty.')).toBeVisible();

});
test('Create Comment (Exceptional - XSS Attack)', async ({ page }) => {
  // Navigate to the main page
  await page.goto(BASE_URL);
  // Click on the login link
  await page.getByRole('link', { name: 'Login' }).click();
  // Fill in the email and password fields
  await page.getByRole('textbox', { name: 'Email' }).click();
  await page.getByRole('textbox', { name: 'Email' }).fill('alice@example.com');
  await page.getByRole('textbox', { name: 'Password' }).click();
  await page.getByRole('textbox', { name: 'Password' }).fill('password');
  // Click the login button
  await page.getByRole('button', { name: 'Login' }).click();
  await expect(page.getByText('Logged in!')).toBeVisible();
  // Navigate to the specific review
  await page.getByRole('link', { name: 'Reviews' }).click();
  // Click on the review titled "Best RPG ever"
  await page.getByRole('link', { name: 'Great adventure' }).click();
  // Listen for the next dialog message
  page.once('dialog', async (dialog) => {
    const message = dialog.message();
    expect(message).toBe('Hacked!');
    await dialog.accept(); // Accept the alert
  });
  // Fill in and submit the comment form
  await page.locator('#comment_body').click();
  await page.locator('#comment_body').fill('<script>alert("Hacked!")</script>');
  await page.getByRole('button', { name: 'Post Comment' }).click();

  //Delete Comment
  //Listen for the next dialog message
  page.once('dialog', async (dialog) => {
    console.log(`Dialog message: ${dialog.message()}`);
    await dialog.accept(); // Accept the confirmation (click "OK")
  });
  // Click the delete link for the comment
  await page.getByRole('link', { name: 'Delete', exact: true }).click();
  // Verify the comment was deleted
  await expect(page.getByText('Comment deleted!')).toBeVisible();


});
# review_blog

A lightweight Ruby on Rails application for creating and browsing reviews,
items, categories, tags and comments. This app uses Rails 8 with importmap/
Propshaft for JavaScript and ships with a simple SQLite development database.

**This README** documents how to get the application running locally and how to 
run tests

**Tech stack**
- **Framework**: Rails 8.1.x
- **Database (dev/test)**: SQLite (see `config/database.yml`)
- **Server**: Puma

## Getting started

Prerequisites
- Ruby compatible with Rails 8 (use a modern Ruby 3.x interpreter).
- Bundler (gem bundler)

Recommended: run inside your WSL Ubuntu environment (this repo lives in WSL, I used Ubuntu -24.04).

Quick start (run in WSL/bash):

```bash
# clone
git clone <your-repo-url> review_blog
cd review_blog

# install gems
bundle install

# create & migrate the database
rails db:create db:migrate db:seed

# run the Rails server
./bin/rails server
```

Open http://localhost:3000 in your browser.

## Configuration
- App configuration is in `config/`

## Testing
This project includes Playwright end-to-end tests.

- **Prepare test database:** create and migrate the test database before running Rails tests.

```bash
# from the project root
bin/rails db:create db:migrate RAILS_ENV=test
```

- **Playwright (end-to-end) tests:** Playwright tests are in the `tests/` directory. Install Node dependencies and Playwright browsers, then run tests with the Playwright test runner.

```bash
# install Node deps
npm install
# install Playwright browser
npx playwright install
# run Playwright tests
npx playwright test
```
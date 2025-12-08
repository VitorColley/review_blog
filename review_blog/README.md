# review_blog

A lightweight Ruby on Rails application for creating and browsing reviews,
items, categories, tags and comments. This app uses Rails 8 with importmap/
Propshaft for JavaScript and ships with a simple SQLite development database.

**This README** documents how to get the application running locally and how to 
run tests

**Tech stack**
- **Framework**: Rails 8.1.x
- **Database (dev/test)**: SQLite (see `config/database.yml`)
- **JS/Assets**: `importmap-rails`, `propshaft`, Turbo + Stimulus
- **Server**: Puma

## Getting started

Prerequisites
- Ruby compatible with Rails 8 (use a modern Ruby 3.x interpreter).
- Bundler (gem bundler)

Recommended: run inside your WSL Ubuntu environment (this repo lives in WSL).

Quick start (run in WSL/bash):

```bash
# clone (if you haven't already)
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
- App configuration lives in `config/` and its environment-specific files
	(`config/environments/*.rb`).
- Credentials are managed with Rails encrypted credentials (`config/credentials.yml.enc`).

## Testing
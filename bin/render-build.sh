#!/usr/bin/env bash
# exit on error
set -o errexit

# Precompile assets
bundle exec rake assets:precompile

# Install gems and migrate the database
bundle install
rails db:migrate

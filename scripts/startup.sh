#!/bin/bash
# Startup scripts
rm -f /ibid/tmp/pids/server.pid
bundle update
bundle install
rails db:create
rails db:migrate
rails db:seed
rails s -b 0.0.0.0

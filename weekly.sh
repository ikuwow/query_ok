#!/bin/bash

bundle exec middleman article "weekly-$(date -d '1 week ago' +%Y%m%d)"
open "https://twilog.org/ikuwow/date-$(date -d '1 week ago' +%y%m%d)/asc"

#!/usr/bin/env bash

set -eu

if [ -z "${1:-}" ]; then
  echo "Usage: $0 <title>"
  exit 1
fi

title="$1"

git fetch
git switch -c "article/$title" "remotes/origin/HEAD"

bundle install
bundle exec middleman article "$title"

git add source/posts
git commit -n -m "Article ${title} init"
git push -u

echo ""
echo "Article ${title} created."

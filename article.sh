#!/usr/bin/env bash

set -eu

title="$1"

git fetch
git switch -c "article/$title" "remotes/origin/HEAD"

bundle exec middleman article "$title"

git add source/posts
git commit -n -m "Article ${title} init"
git push -u

echo ""
echo "Article ${title} created."

#!/usr/bin/env bash

set -eu

bucket="s3://queryok.ikuwow.com/"

# aws s3 sync uploads a same-size file only when its mtime is newer
# than the S3 object, and an asset hash change keeps HTML the same size.
# Build-time mtimes can predate the previous deploy's upload.
find build -type f -exec touch {} +

# New assets go up before the HTML that references them, and assets only the
# previous HTML referenced are deleted after the new HTML is live.
aws s3 sync build "$bucket" --exclude '*.html'
# Browsers revalidate HTML on every visit, so no reader keeps HTML that
# references assets a later deploy has deleted.
aws s3 sync --delete build "$bucket" --exclude '*' --include '*.html' --cache-control no-cache
aws s3 sync --delete build "$bucket" --exclude '*.html'

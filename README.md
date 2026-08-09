# Query OK.

[![CI](https://github.com/ikuwow/query_ok/actions/workflows/ci.yml/badge.svg)](https://github.com/ikuwow/query_ok/actions/workflows/ci.yml)

ikuwow's blog.

## Made from

* Middleman
* Pure CSS Framework
* [utterances](https://utteranc.es) ([comment repo](https://github.com/ikuwow/queryok_comments))

## Development

Install dependencies:

```bash
bundle install
npm install
```

Start the dev server:

```bash
bundle exec middleman server
```

The site runs at http://localhost:4567/. Frontend assets are built and watched automatically via the webpack external pipeline.

## Writing an article

```bash
./article.sh <title>
```

This creates a branch, generates the article scaffold, commits and pushes it.

## How to Deploy

Pushing to `master` deploys automatically via GitHub Actions. Manual deployment:

```bash
aws s3 sync --delete build s3://<bucket>/
```

## License

All rights reserved.

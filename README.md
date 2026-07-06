Query OK.
[![CircleCI](https://circleci.com/gh/ikuwow/query_ok.svg?style=svg)](https://circleci.com/gh/ikuwow/query_ok)
===========================

ikuwow's blog.

## Made from

* Middleman
* Pure CSS Framework
* [utterances](https://utteranc.es) ([comment repo](https://github.com/ikuwow/queryok_comments))

## Development

Install dependencies:

```
bundle install
npm install
```

Start the dev server:

```
bundle exec middleman server
```

The site runs at http://localhost:4567/. Frontend assets are built and watched automatically via the webpack external pipeline.

## Writing an article

```
./article.sh <title>
```

This creates a branch, generates the article scaffold, commits and pushes it.

## How to Deploy

```
aws s3 sync --delete build s3://queryok.ikuwow.com/
```

## License

All rights reserved.

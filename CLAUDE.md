# CLAUDE.md

## Project Overview

This is ikuwow's personal blog "Query OK." built with Middleman, a static site generator. The blog is deployed to AWS S3 + CloudFront and features Japanese/English technical and life articles.

## Common Development Commands

### Development Server

```bash
# Install dependencies
bundle install
npm install

# Start development server (http://localhost:4567/)
bundle exec middleman server
```

Frontend assets are built and watched automatically: webpack runs as a Middleman external pipeline (`npm run watch` in server mode, `npm run build` in build mode).

### Build Commands

```bash
# Build static site for production
bundle exec middleman build

# Build frontend assets only
npm run build
```

### Linting Commands

```bash
# Run all linters
npm run eslint          # JavaScript
npm run stylelint       # CSS/SCSS
npm run markdownlint    # Markdown
npm run textlint        # Japanese text in posts
bundle exec rubocop     # Ruby code
bundle exec erb_lint source/**/*.erb  # ERB templates

# Fix auto-fixable textlint issues
npm run textlint-fix
```

CI runs each lint command above except `textlint-fix` on every push and fails on any error, so run the ones covering the files you changed before pushing.

### Deployment

The site is automatically deployed via CircleCI when pushing to the master branch. Manual deployment, after `bundle exec middleman build`:

```bash
./deploy.sh
```

## Architecture and Structure

### Key Directories

- `source/posts/` - Blog articles (layout in Article Structure)
- `source/layouts/` - ERB layout templates
- `source/stylesheets/` - SCSS stylesheets (compiled via Webpack)
- `extensions/` - Custom Middleman extensions (oEmbed converter)
- `build/` - Generated static files (gitignored)

### Technology Stack

- Static Site Generator: Middleman with middleman-blog (Middleman version constrained in Gemfile, both resolved in Gemfile.lock)
- Languages: Ruby + Node.js (versions pinned in .tool-versions)
- Frontend Build: Webpack 5
- CSS Framework: Pure CSS
- Markdown: Redcarpet with fenced code blocks, smartypants, autolink, strikethrough
- Comments: utterances (separate repo: ikuwow/queryok_comments)
- Syntax Highlighting: middleman-syntax

### Article Structure

Articles are created in `source/posts/{year}/{year}-{month}-{day}-{title}/index.html.md` format.

Use `./article.sh <title>` to create a new article (creates a branch, generates the article, commits and pushes), or `bundle exec middleman article <title>` for generation only.

Front matter keys:

- `title`
- `date` (format: `YYYY-MM-DD HH:MM JST`)
- `tags` (comma-separated string, multiple tags allowed)
- `thumbnail` (optional)
- `published: false` (optional, marks a draft)

The article URL is `/entry/{title}/`, where `{title}` comes from the directory name's title part, not from the front matter `title` (which is typically Japanese). Keep the URL of every published article unchanged: utterances keys comment threads by pathname (`issue-term="pathname"`), so a changed URL orphans the thread. Renaming an article's directory changes its URL, and changing `blog.permalink` or `directory_indexes` in `config.rb` changes every article's URL.

### Custom Extensions

- oEmbed Converter: Converts standalone Twitter/X status URLs in Markdown into embedded HTML (Twitter/X only)
- Cache stored in `.cache/oembed_converter_v2/`
- A failed oEmbed fetch fails `middleman build`, so keep `.cache/`: a status URL the oEmbed endpoint no longer resolves, such as a deleted tweet, builds only from its cached response
- `.cache/` is gitignored, so a new worktree starts without it; copy it from the main checkout before running `middleman build` there

### Pre-commit Hooks

When a hook in `.pre-commit-config.yaml` rewrites files and fails the commit, re-stage them and commit again.

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

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

# Watch and build frontend assets
npm run watch
```

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

### Deployment

The site is automatically deployed via CircleCI when pushing to the master branch. Manual deployment:

```bash
aws s3 sync --delete build s3://queryok.ikuwow.com/
```

## Architecture and Structure

### Key Directories

- `source/posts/` - Blog articles organized by year (e.g., `2024/2024-01-01-title/index.html.md`)
- `source/layouts/` - ERB layout templates
- `source/stylesheets/` - SCSS stylesheets (compiled via Webpack)
- `extensions/` - Custom Middleman extensions (oEmbed converter)
- `build/` - Generated static files (gitignored)

### Technology Stack

- **Static Site Generator**: Middleman 4.6.1 with middleman-blog
- **Languages**: Ruby 3.3.2 (via asdf) + Node.js 20.12.2
- **Frontend Build**: Webpack 5
- **CSS Framework**: Pure CSS
- **Markdown**: Redcarpet with fenced code blocks, smartypants, autolink
- **Comments**: utterances (separate repo: ikuwow/queryok_comments)
- **Syntax Highlighting**: middleman-syntax

### Article Structure

Articles are created in `source/posts/{year}/{year}-{month}-{day}-{title}/index.html.md` format. Front matter includes:

- title
- created_at
- tags
- eyecatch (optional)

### Custom Extensions

- **oEmbed Converter**: Automatically converts URLs (Twitter, YouTube, etc.) to embedded content
- Cache stored in `.cache/oembed_converter_v2/`

### Pre-commit Hooks

Various linters are configured via `.pre-commit-config.yaml` including shellcheck for shell scripts.

## Important Notes

- Always ensure files end with a newline
- Remove trailing whitespace (except in Markdown where meaningful)
- The blog uses Japanese textlint presets - be mindful when editing Japanese content
- Git commits should include co-authorship when working with AI tools

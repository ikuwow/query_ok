# frozen_string_literal: true

###
# Blog settings
###

$base_url = 'https://queryok.ikuwow.com'

Time.zone = 'Tokyo'

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  blog.permalink = 'entry/{title}.html'
  # Matcher for blog source files
  # blog.sources = "{year}-{month}-{day}-{title}.html"
  blog.sources = 'posts/{year}-{month}-{day}-{title}.html'
  # blog.taglink = "tags/{tag}.html"
  # blog.layout = "layout"
  blog.layout = 'layouts/article_layout'
  # blog.summary_separator = /(READMORE)/
  blog.summary_length = 200
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"
  blog.default_extension = '.md'

  blog.tag_template = 'tag.html'
  blog.calendar_template = 'calendar.html'

  # Enable pagination
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

page '/feed.xml', layout: false

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :minify_html

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
  #
  #
  activate :favicon_maker, icons: {
    '_favicon_template.png' => [
      { icon: 'apple-touch-icon-152x152-precomposed.png' },
      { icon: 'apple-touch-icon-114x114-precomposed.png' },
      { icon: 'apple-touch-icon-72x72-precomposed.png' },
      { icon: 'favicon.png', size: '16x16' },
      { icon: 'favicon.ico', size: '64x64,32x32,24x24,16x16' }
    ]
  }
end

activate :directory_indexes

activate :syntax
# :line_numbers => true

set :markdown_engine, :redcarpet # not kramdown
set :markdown,
    fenced_code_blocks: true,
    smartypants: true,
    autolink: true,
    strikethrough: true

set :url_root, $base_url
activate :search_engine_sitemap

## imageoptim is disabled because of the bug.
## please minify manually
# activate :imageoptim, :pngout => false, :svgo => false

activate :s3_sync do |s3_sync|
  s3_sync.region = 'ap-northeast-1'
  s3_sync.index_document = 'index.html'
  s3_sync.error_document = '404/index.html'
  s3_sync.prefer_gzip = false
end

activate :external_pipeline,
  name: :webpack,
  command: 'npm run build',
  source: "./build",
  latency: 1

ignore '/.*.swp'
ignore '/**/.*.swp'

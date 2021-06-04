# frozen_string_literal: true

require 'uglifier'

Time.zone = 'Tokyo'

set :url_root, 'https://queryok.ikuwow.com'
set :blog_title, 'Query OK.'
set :blog_subtitle, 'ikuwowの技術/ガジェット/内省'

activate :blog do |blog|
  blog.permalink = 'entry/{title}.html'
  blog.sources = 'posts/{year}-{month}-{day}-{title}/index.html'
  blog.layout = 'layouts/article_layout'
  blog.summary_length = 200
  blog.default_extension = '.md'
  blog.tag_template = 'tag.html'
  blog.calendar_template = 'calendar.html'
end

page '/feed.xml', layout: false

activate :livereload

set :css_dir, 'stylesheets'
set :images_dir, 'images'

ignore 'entry.js'
ignore 'critical.js'
ignore 'stylesheets/babylink.css'
ignore '/.*.swp'
ignore '/**/.*.swp'

configure :build do
  activate :minify_css
  activate :minify_javascript, compressor: lambda {
    Uglifier.new(harmony: true)
  }
  activate :minify_html

  activate :asset_hash

  activate :favicon_maker, icons: {
    '_favicon_template.png' => [
      { icon: 'apple-touch-icon.png', size: '180x180' },
      { icon: 'apple-touch-icon-precomposed.png', size: '180x180' },
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

set :markdown_engine, :redcarpet # not kramdown
set :markdown,
    fenced_code_blocks: true,
    smartypants: true,
    autolink: true,
    strikethrough: true

activate :s3_sync do |s3_sync|
  s3_sync.region = 'ap-northeast-1'
  s3_sync.index_document = 'index.html'
  s3_sync.error_document = '404/index.html'
  s3_sync.prefer_gzip = false
end
default_caching_policy max_age: (60 * 60 * 24 * 365)

activate :external_pipeline,
         name: :webpack,
         command: build? ? 'npm run build' : 'npm run watch',
         source: '.tmp/dist',
         latency: 1

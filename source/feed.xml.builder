# frozen_string_literal: true

xml.instruct!
xml.feed 'xmlns' => 'http://www.w3.org/2005/Atom' do
  site_url = app.config.url_root
  xml.title app.config.blog_title
  xml.subtitle app.config.blog_subtitle
  xml.link 'href' => URI.join(site_url, current_page.path), 'rel' => 'self', 'type' => 'application/atom+xml'
  xml.link 'href' => URI.join(site_url, blog.options.prefix.to_s), 'rel' => 'alternate', 'type' => 'text/html'
  xml.updated(blog.articles.first.date.to_time.iso8601) unless blog.articles.empty?
  xml.author { xml.name '@ikuwow' }

  blog.articles[0..10].each do |article|
    xml.entry do
      xml.title article.title
      xml.link 'href' => URI.join(site_url, article.url)
      xml.published article.date.to_time.iso8601
      # xml.updated File.mtime(article.source_file).iso8601 # TODO: record and display article updated time
      xml.author { xml.name '@ikuwow' }
      xml.content article.body, 'type' => 'html'
    end
  end
end

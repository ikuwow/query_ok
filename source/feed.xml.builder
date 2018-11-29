# frozen_string_literal: true

xml.instruct!
xml.feed 'xmlns' => 'http://www.w3.org/2005/Atom' do
  site_url = $base_url
  xml.title 'Query OK.'
  xml.subtitle 'ikuwowの技術ブログ'
  xml.id URI.join(site_url, blog.options.prefix.to_s)
  xml.link 'href' => URI.join(site_url, blog.options.prefix.to_s)
  xml.link 'href' => URI.join(site_url, current_page.path), 'rel' => 'self'
  unless blog.articles.empty?
    xml.updated(blog.articles.first.date.to_time.iso8601)
  end
  xml.author { xml.name '@ikuwow' }

  blog.articles[0..5].each do |article|
    xml.entry do
      xml.title article.title
      xml.link 'rel' => 'alternate', 'href' => URI.join(site_url, article.url)
      xml.id URI.join(site_url, article.url)
      xml.published article.date.to_time.iso8601
      xml.updated File.mtime(article.source_file).iso8601
      xml.author { xml.name '@ikuwow' }
      # xml.summary article.summary, "type" => "html"
      xml.content article.body, 'type' => 'html'
    end
  end
end

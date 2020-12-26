# frozen_string_literal: true

xml.instruct!
xml.urlset 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  pages = sitemap.resources.select do |resource|
    resource.path.end_with?(File.extname(app.config.index_file))
  end

  pages.each do |page|
    xml.url do
      xml.loc File.join(app.config.url_root, page.url)
      xml.lastmod(File.mtime(page.source_file).iso8601) if page.source_file
      xml.changefreq 'monthly'
    end
  end
end

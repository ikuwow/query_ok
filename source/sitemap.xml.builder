xml.instruct!
xml.urlset 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  sitemap.resources.select do |resource|
    xml.url do
      xml.loc "#{@base_url}#{resource.url}"
    end
  end
end

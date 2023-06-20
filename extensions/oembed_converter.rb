# frozen_string_literal: true

require 'oembed'

# OEmbedConverter: Convert OEmbed URLs to HTML
class OEmbedConverter < Middleman::Extension
  option :cache_dir, '.cache/oembed_converter/'

  def initialize(app, options_hash = nil, &)
    super

    # Currently only Twitter is supported
    @cache_dir = File.join(app.root, options.cache_dir)

    OEmbed::Providers.register_all

    app.before_render do |body, path|
      convert(body) if path.end_with?('.md', '.markdown', '.mkd')
    end
  end

  def convert(body)
    target_services.each do |service|
      body.gsub!(service[:regex]) do |url|
        get_oembed_response(url, service[:query])
      end
    end
    body
  end

  private

  def target_services
    [
      {
        name: 'twitter',
        # yushakobo is ignored
        regex: %r{^https?://twitter.com/(?!yushakobo)[a-zA-Z0-9_]+/status/\d+$},
        query: { omit_script: '1' }
      }
    ]
  end

  def get_oembed_response(url, query = {})
    cache_file = File.join(@cache_dir, Digest::SHA256.hexdigest(url))

    return Marshal.load(File.binread(cache_file)) if File.exist?(cache_file)

    html = OEmbed::Providers.get(url, query).html

    FileUtils.mkdir_p(@cache_dir)
    File.binwrite(cache_file, Marshal.dump(html))

    html
  end
end

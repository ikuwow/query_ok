# frozen_string_literal: true

require 'oembed'

# OEmbedConverter: Convert OEmbed URLs to HTML
class OEmbedConverter < Middleman::Extension
  def initialize(app, options_hash = nil, &block)
    super

    # Currently only Twitter is supported
    @target_regex = %r{https?://twitter.com/[a-zA-Z0-9_]+/status/\d+}
    @cache_dir = File.join(app.root, '.cache/oembed_converter/')

    OEmbed::Providers.register_all

    app.before_render do |body|
      convert(body)
    end
  end

  def convert(body)
    body.gsub!(@target_regex) do |url|
      get_oembed_response(url)
    end
  end

  private

  def get_oembed_response(url)
    cache_filename = Digest::SHA256.hexdigest(url)
    cache_file = File.join(@cache_dir, cache_filename)

    p 'Read cache'
    if File.exist?(cache_file)
      p 'Read cache'
      return Marshal.load(File.binread(cache_file))
    end

    p 'GET request'
    html = OEmbed::Providers.get(url).html

    p 'Write cache'
    FileUtils.mkdir_p(@cache_dir)
    File.binwrite(cache_file, Marshal.dump(html))

    html
  end
end

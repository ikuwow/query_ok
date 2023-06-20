# frozen_string_literal: true

require 'oembed'

# OEmbedConverter: Convert OEmbed URLs to HTML
class OEmbedConverter < Middleman::Extension
  def initialize(app, options_hash = nil, &block)
    super

    # Currently only Twitter is supported
    # yushakobo is ignored
    @target_regex = %r{^https?://twitter.com/(?!yushakobo)[a-zA-Z0-9_]+/status/\d+$}
    @cache_dir = File.join(app.root, '.cache/oembed_converter/')

    OEmbed::Providers.register_all

    app.before_render do |body, path|
      puts "Before rendering #{path}"
      if path.end_with?('.md', '.markdown', '.mkd')
        convert(body)
      end
    end
  end

  def convert(body)
    body.gsub!(@target_regex) do |url|
      puts "matched url: #{url}"
      get_oembed_response(url)
    end
  end

  private

  def get_oembed_response(url)
    cache_file = File.join(@cache_dir, Digest::SHA256.hexdigest(url))

    if File.exist?(cache_file)
      puts 'Read cache'
      return Marshal.load(File.binread(cache_file))
    end

    html = OEmbed::Providers.get(url, { omit_script: '1' }).html

    puts 'Write cache'
    FileUtils.mkdir_p(@cache_dir)
    File.binwrite(cache_file, Marshal.dump(html))

    html
  end
end

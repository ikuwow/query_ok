# frozen_string_literal: true

require 'oembed'

# OEmbedConverter: Convert OEmbed URLs to HTML
class OEmbedConverter < Middleman::Extension
  def initialize(app, options_hash = nil, &block)
    super

    # Currently only Twitter is supported
    @target_regex = %r{https?://twitter.com/[a-zA-Z0-9_]+/status/\d+}

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

  def get_oembed_response(url)
    # TODO: Cache response
    OEmbed::Providers.get(url).html
  end
end

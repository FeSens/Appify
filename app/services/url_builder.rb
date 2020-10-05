class UrlBuilder < ApplicationService
  attr_reader :url, :campaign_name, :medium

  def initialize(url, campaign_name, medium="push")
    @url = I18n.transliterate(url)
    @campaign_name = I18n.transliterate(campaign_name)
    @medium = I18n.transliterate(medium)
  end

  def call
    uri = URI.parse(pad_url)
    q = uri.query.present? ? Rack::Utils.parse_nested_query(uri.query) : {}
    q["utm_source"] = "aplicatify"
    q["utm_medium"] = medium
    q["utm_campaign"] = campaign_name
    q["ref"] = "aplicatify"
    "https://#{uri.host}#{uri.path}?#{q.to_query}"
  end

  private

  def pad_url
    "https://#{www}#{scheme}"
  end

  def scheme
    url.gsub("https://", "").gsub("http://", "")
  end

  def www
    return if url.count(".") >= 2
    "www."
  end
end
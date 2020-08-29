class UrlFormater < ApplicationService
  attr_reader :url, :campaign_name, :medium

  def initialize(url, campaign_name, medium="push")
    @url = url
    @campaign_name = campaign_name
    @medium = medium
  end

  def call
    build_url
  end

  private

  def build_url
    uri = URI.parse(pad_url)
    q = uri.query.present? ? Rack::Utils.parse_nested_query(uri.query) : {}
    q["utm_source"] = "aplicatify"
    q["utm_medium"] = medium
    q["utm_campaign"] = campaign_name
    q["ref"] = "aplicatify"
    return "https://#{uri.host}#{uri.path}?#{q.to_query}"
  end

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
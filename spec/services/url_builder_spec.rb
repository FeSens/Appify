require "rails_helper"

describe UrlBuilder do
  let(:campaign) { Faker::Superhero.name }
  let(:query_dict) { { ref: "aplicatify", utm_campaign: campaign, utm_medium: "push", utm_source: "aplicatify" } }
  let(:www) { url.count(".") >= 2 ? "" : "www." }
  let(:expeced_url) { "https://#{www}#{url.gsub("https://", "").gsub("http://", "")}?#{query_dict.to_query}" }

  shared_examples "output a valid url" do
    it { expect(described_class.call(url, campaign)).to eq(expeced_url) }
  end

  context "without www and scheme" do
    let(:url) { "google.com.br" }

    include_examples "output a valid url"
  end

  context "without www" do
    let(:url) { "https://google.com.br" }

    include_examples "output a valid url"
  end

  context "without www and only one \\." do
    let(:url) { "https://google.com" }

    include_examples "output a valid url"
  end

  context "with https://" do
    let(:url) { Faker::Internet.url }

    include_examples "output a valid url"
  end

  context "with http://" do
    let(:url) { Faker::Internet.url.gsub("https://", "http://") }

    include_examples "output a valid url"
  end

  context "with full url" do
    let(:url) { "https://www.google.com.br" }

    include_examples "output a valid url"
  end

  context "with full url and only two \\." do
    let(:url) { "https://www.google.com" }

    include_examples "output a valid url"
  end

  context "having previously attached query params" do
    let(:url) { "https://www.google.com/?p1=test_1&p2=2" }
    let(:expeced_url) { "https://#{www}#{url.gsub("https://", "").gsub("http://", "")}&#{query_dict.to_query}" }

    include_examples "output a valid url"
  end
end

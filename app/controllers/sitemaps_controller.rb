class SitemapsController < ApplicationController
  def generate
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") {
        Page.published.each do |page|
          xml.url {
            xml.loc page.url
            xml.lastmod page.updated_at 
            xml.priority (page.slug == "/") ? 1.0 : 0.8 
          }
        end
      }
    end

    render :xml => builder.to_xml
  end
end

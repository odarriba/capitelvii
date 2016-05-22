class SitemapsController < ApplicationController
  def generate
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") {
        Page.published.each do |page|
          priority = 1.0
          priority -= 0.2 unless (page.slug == "/")
          priority -= 0.1 unless (page.show_in_menu || page.slug == "/")

          xml.url {
            xml.loc page.url
            xml.lastmod page.updated_at.iso8601
            xml.priority priority.round(1)
          }
        end
      }
    end

    render :xml => builder.to_xml
  end
end

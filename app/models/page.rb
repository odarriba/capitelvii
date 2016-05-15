class Page < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  validates :title, :slug, presence: true

  default_scope ->() { order('pages.order ASC, title DESC') }

  scope :published, ->() {
    where(draft: false)
  }

  scope :menu_items, ->() {
    where(show_in_menu: true)
  }

  # Generate friendly_id when the slug is blank
  def should_generate_new_friendly_id?
    slug.blank?
  end

  # Helper function to generate the full URL of the page
  #
  def url
    return root_url if (slug == "/")
    return page_url(slug: slug)
  end

  # Helper function to generate the relative URL of the page
  #
  def path
    return root_path if (slug == "/")
    return page_path(slug: slug)
  end
end

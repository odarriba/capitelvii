class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  validates :title, :slug, presence: true

  default_scope ->() { order('pages.order ASC, title DESC') }

  scope :published, ->() {
    where(draft: false)
  }

  def should_generate_new_friendly_id?
    slug.blank?
  end
end

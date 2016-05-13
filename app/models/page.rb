class Page < ActiveRecord::Base
  validates :title, :slug, presence: true

  default_scope ->() { order('pages.order ASC, title DESC') }

  scope :published, ->() {
    where(draft: false)
  }
end

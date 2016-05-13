class Page < ActiveRecord::Base
  validate :title, :slug, presence: true

  default_scope order('order ASC name DESC')

  scope :published, ->() {
    where(draft: false)
  }
end

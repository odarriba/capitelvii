class Gallery < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  has_many :pictures, dependent: :destroy

  accepts_nested_attributes_for :pictures,
    :allow_destroy => true,
    :reject_if     => :all_blank

  validates :title, :slug, :pictures, presence: true
  validates :slug, uniqueness: true
  validates :position, numericality: { only_integer: true }

  default_scope ->() {
    order("position ASC")
  }

  scope :published, ->() {
    where(draft: false)
  }

  # Generate friendly_id when the slug is blank
  def should_generate_new_friendly_id?
    slug.blank?
  end
end

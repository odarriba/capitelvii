class ContactRequest < ActiveRecord::Base
  validates_presence_of :name, :email, :phone, :body

  validates :name, length: { in: 2..255 }
  validates :email, length: { in: 6..255 }
  validates :phone, length: { is: 9 }
  validates :body, length: { in: 20..255 }

  validates :phone, numericality: { only_integer: true, greater_than: 0 }

  default_scope ->() { order('updated_at DESC') }

  after_create :send_email

  protected

  # Send the information to the notify address after saving the object
  #
  def send_email
    ContactRequestMailer.notify_email(self).deliver_now
  end
end

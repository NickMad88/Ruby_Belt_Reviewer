class User < ActiveRecord::Base
  has_secure_password
  has_many :events
  has_many :comments, dependent: :destroy
  has_many :attendees, dependent: :destroy
  has_many :event_comments, through: :comment, source: :events
  has_many :events_attend, through: :attendees, source: :events
  EMAIL_REGEX = /\A[A-Za-z0-9\.]+@[A-Za-z]+\.[A-Za-z]{3}/
  validates :first_name, :last_name, :email, :city, :state, presence: true, length: { minimum: 2 }
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  before_save :downcase_email

  def downcase_email
      self.email.downcase!
  end
end

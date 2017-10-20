class Event < ActiveRecord::Base
    belongs_to :user
    has_many :attendees, dependent: :destroy
    has_many :comment, dependent: :destroy
    has_many :user_comments, through: :comment, source: :user
    has_many :user_attendees, through: :attendees, source: :user
    validates :name, :city, :state, presence: true, length: { minimum: 2 }
    validates :date, presence: true
    validate :date_in_future

    def date_in_future
        if date < Date.today
            errors.add(:date, "must be in the future")
        end
    end
end

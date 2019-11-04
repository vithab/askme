class Question < ApplicationRecord
  belongs_to :user

  validates :text, :user, presence: true, :text, length: { maximum: 255 }
end

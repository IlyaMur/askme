class Question < ApplicationRecord
  validates :text, presence: true
  validates :text, length: { maximum: 255 }
end

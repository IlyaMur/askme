class Hashtag < ApplicationRecord
  HASHTAG_REGEXP = /#[[:word:]-]+/.freeze

  has_many :question_hashtag, dependent: :destroy
  has_many :questions, through: :question_hashtag

  validates :word,
            presence: true,
            length: { maximum: 20 }

  scope :with_questions, -> { joins(:questions).distinct }
end

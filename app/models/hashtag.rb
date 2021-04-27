class Hashtag < ApplicationRecord
  HASHTAG_REGEXP = /#[[:word:]-]+/.freeze

  has_many :question_hashtag, dependent: :destroy
  has_many :questions, through: :question_hashtag

  validates :word,
            presence: true,
            length: { maximum: 20 }

  def self.find_words_with_tags(string)
    string&.scan(HASHTAG_REGEXP)&.map(&:downcase)&.map { |tag| tag[1..] }
  end
end

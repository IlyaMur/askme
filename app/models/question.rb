class Question < ApplicationRecord
  has_many :question_hashtag, dependent: :destroy
  has_many :hashtags, through: :question_hashtag

  belongs_to :user

  belongs_to :author,
             class_name: 'User',
             optional: true

  validates :text,
            presence: true,
            length: { maximum: 255 }

  after_commit :save_hashtags, on: %i[create update]

  private

  def find_words_with_tags(string)
    string&.scan(Hashtag::HASHTAG_REGEXP)&.map(&:downcase)&.map { |tag| tag[1..] }
  end

  def save_hashtags
    question_hashtag.delete_all

    tags_text = find_words_with_tags(text)
    tags_answer = find_words_with_tags(answer) || []

    (tags_answer | tags_text).each do |tag|
      question_hashtag.create(hashtag: Hashtag.find_or_create_by(word: tag))
    end
  end
end

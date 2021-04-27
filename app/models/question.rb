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

  after_commit :save_hashtags

  private

  def save_hashtags
    tags_text = Hashtag.find_words_with_tags(text)
    tags_answers = Hashtag.find_words_with_tags(answer) || []

    (tags_answers | tags_text).each do |tag|
      question_hashtag.create(hashtag: Hashtag.find_or_create_by(word: tag))
    end
  end
end

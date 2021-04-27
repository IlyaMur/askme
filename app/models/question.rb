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

  after_save :save_hashtags
  after_destroy :del_hashtags_without_questions

  private

  def save_hashtags
    tags_text = Hashtag.find_words_with_tags(text)
    tags_answers = Hashtag.find_words_with_tags(answer) || []

    (tags_answers | tags_text).each do |tag|
      question_hashtag.create(hashtag: Hashtag.find_or_create_by(word: tag))
    end
  end

  def del_hashtags_without_questions
    Hashtag.left_joins(:questions).where(questions: nil).destroy_all
  end
end

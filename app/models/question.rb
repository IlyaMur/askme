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

  after_commit :update_hashtags, on: %i[create update]

  private

  def update_hashtags
    question_hashtag.clear

    "#{text} #{answer}".downcase.scan(Hashtag::HASHTAG_REGEXP).uniq.each do |word|
      hashtags << Hashtag.find_or_create_by(word: word.delete('#'))
    end
  end
end

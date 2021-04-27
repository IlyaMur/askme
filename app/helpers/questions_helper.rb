module QuestionsHelper
  def render_with_hashtags(text)
    text.gsub(/(?:#([[:word:]-]+))/) { hashtag_link(Regexp.last_match(1)) }
  end

  def hashtag_link(tag)
    link_to "##{tag}", hashtag_path(tag), class: 'hashtag'
  end
end

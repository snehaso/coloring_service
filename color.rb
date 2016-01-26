class Color
  SEMAPHORE_COLOR_PALATE = %w(red blue green)

  def initialize(color_scheme = 'black_on_white')
    @color_scheme = color_scheme
  end

  def words_to_html(words)
    words.collect { |w| convert(w) }
  end

  private
  def convert(word)
    return "<span class=#{SEMAPHORE_COLOR_PALATE.sample}>#{word}</span>" if @color_scheme == 'random'
    "<span>#{word}</span>"
  end
end

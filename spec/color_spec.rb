require 'spec_helper'

describe 'Color' do
  it 'return html words without any css(as default scheme is black)' do
    words = %w(My experiments with life by M. K. Gandhi)
    expected = words.collect {|w| "<span>#{w}</span>"}

    expect(Color.new(:black_on_white).words_to_html(words)).to eq(expected)
  end

  it 'return html words with random color scheme' do
    words = %w(My experiments with life by M. K. Gandhi)
    possible_result_set = words.collect do |w|
      Color::SEMAPHORE_COLOR_PALATE.collect { |color| "<span class=#{color}>#{w}</span>"}
    end.flatten

    result = Color.new('random').words_to_html(words)
    result.each{ |r| expect(possible_result_set).to include(r)}
  end
end

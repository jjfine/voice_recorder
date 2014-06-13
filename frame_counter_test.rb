require 'minitest/autorun'
require_relative './frame_counter'

class FrameCounterTest < Minitest::Test
  def setup
    @threshold = 5
    @counter = FrameCounter.new @threshold
  end

  def test_ignores_a_few_voice_frames
    @threshold.times { @counter.increment_silence }
    (@threshold - 1).times { @counter.increment_voice }

    assert_equal @threshold, @counter.silence
  end

  def test_reset_silence_after_seeing_enough_voice_frames
    @threshold.times { @counter.increment_silence }
    @threshold.times { @counter.increment_voice }

    assert_equal 0, @counter.silence 
  end

  def test_ignores_a_few_silent_frames
    @threshold.times { @counter.increment_voice }
    (@threshold - 1).times { @counter.increment_silence }

    assert_equal @threshold, @counter.voice
  end

  def test_reset_voice_after_seeing_enough_silent_frames
    @threshold.times { @counter.increment_voice }
    @threshold.times { @counter.increment_silence }

    assert_equal 0, @counter.voice 
  end
end
